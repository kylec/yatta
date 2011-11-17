class GoalsController < ApplicationController
  require 'builder'
  
  def new
    @title = "Create Goal"
  end

  def create
    goal_title = params[:newgoal][:goal_title]
    goal_description = params[:newgoal][:goal_description]  
    xml_path = "/Users/kylito/"
    xml_file = "#{goal_title}-#{current_user.id}.xml"
    file = File.new("#{xml_path}#{xml_file}", "w")
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
end
