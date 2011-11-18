class GoalsController < ApplicationController
  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy
  
  require 'builder'
  
  def new
    @title = "Create Goal"
  end

  def create
    goal_title = params[:newgoal][:goal_title]
    goal_description = params[:newgoal][:goal_description]  
    xml_file = "#{goal_title}-#{current_user.id}.xml"
    file = File.new("#{GoalAppAlbert::Application::XMLPATH}#{xml_file}", "w")
    xml = Builder::XmlMarkup.new :target => file  
    xml.instruct!
    xml.goal_title(goal_title)
    xml.goal_description(goal_description)
    numMilestones = params[:newgoal].size - 2
    numMilestones.times do |i| 
      xml.milestone{ 
        xml.title(params[:newgoal]["#{i}"][:title])
        xml.description(params[:newgoal]["#{i}"][:description])
      }
    end
    file.close  
    
    @goal = current_user.goals.build(:schedule => xml_file)
    if @goal.save
      flash[:success] = "Goal created!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
    
  end
  
  private

    def authorized_user
      @goal = current_user.goals.find_by_id(params[:id])
      redirect_to root_path if @goal.nil?
    end
end
