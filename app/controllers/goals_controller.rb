class GoalsController < ApplicationController
  require 'builder'

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  # constants to validate fields on this page
  TITLE_MAX_LENGTH = 30
  DESCRIPTION_MAX_LENGTH = 140

  def new
    @title = "Create Goal"
  end

  def create
    # initialize error_msgs to no errors
    @error_msgs = Array.new

    goal_title = validate_field(params[:newgoal][:goal_title],
                                {:empty => true,
                                 :length => TITLE_MAX_LENGTH,
                                 :field_name => "Goal Title" })
    goal_description = validate_field(params[:newgoal][:goal_description],
                                {:length => DESCRIPTION_MAX_LENGTH,
                                 :field_name => "Goal Description"})
    xml_file = "#{goal_title}-#{current_user.id}.xml"
    file = File.new("#{GoalAppAlbert::Application::XMLPATH}#{xml_file}", "w")
    xml = Builder::XmlMarkup.new :target => file  
    xml.instruct!
    xml.goal_title(goal_title)
    xml.goal_description(goal_description)
    numMilestones = params[:newgoal].size - 2
    numMilestones.times do |i| 
      xml.milestone{ 
        xml.title(validate_field(params[:newgoal]["#{i}"][:title],
                                 {:empty => true,
                                  :length => TITLE_MAX_LENGTH,
                                  :field_name => "Milestone #{i+1} Title"}))
        xml.description(validate_field(params[:newgoal]["#{i}"][:description],
                                       {:length => DESCRIPTION_MAX_LENGTH,
                                        :field_name => "Milestone #{i+1} Description"}))
      }
    end
    file.close  

    if(!@error_msgs.empty?)
      @error_msgs.length().times do |i|
        flash["error#{i}"] = @error_msgs[i]
      end
      redirect_to newGoal_path
    else
      @goal = current_user.goals.build(:schedule => xml_file)
      if (@goal.save())
        flash[:success] = "Goal created!"
        redirect_to root_path
      else
        render 'pages/home'
      end
    end
  end

  def destroy
    
  end
  
  private

    def authorized_user
      @goal = current_user.goals.find_by_id(params[:id])
      redirect_to root_path if @goal.nil?
    end

    def validate_field (value, constraints)
      # check if field name is passed
      fieldname = ""
      if (constraints.has_key?(:field_name))
        fieldname = constraints[:field_name]
      end

      # check if field is empty
      if (constraints.has_key?(:empty) && value.empty?)
        @error_msgs << "Error: #{fieldname} cannot be empty"
      end

      # check if the field has the right length
      if (constraints.has_key?(:length))
        if (value.length() > constraints[:length])
          @error_msgs << "Error: #{fieldname} has to be less than #{constraints[:length]} letters"
        end
      end

      return value
    end
end
