class GoalsController < ApplicationController
  require 'builder'

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def new
    @goal = Goal.new
    #3.times do |i| 
    #  milestone = @goal.milestones.build()
    #end
    @title = GoalsHelper::CREATE_TITLE
  end

  def create
    #todo: check if goal title exists for current_user
    @goal = current_user.goals.build(params[:goal])
    index = 0
    @goal.milestones.each do |i|
      i.position = index
      index += 1
    end
   
    if @goal.save
      flash[:notice] = "Successfully created goal."
      redirect_to user_goal_path(current_user.username, @goal.title)
    else
      render :action => 'new'
    end
  end

  def destroy
    
  end
  
  def show
    @title = "Goal"
    @goal = Goal.find_by_title(params[:id])
    @goal.milestones.sort_by!(&:position)
    @userGoalRelationship = current_user.user_goal_relationships.find_by_goal_id(@goal) 
  end

  def edit
    @title = GoalsHelper::EDIT_TITLE
    @goal = Goal.find_by_title(params[:id])
    @goal.milestones.sort_by!(&:position)
  end

  def update
    # get the database goal data
    @databaseGoal = Goal.find_by_title(params[:id])
    if (@databaseGoal.title.to_s != params["goal"]["title"].to_s) 
      @databaseGoal.title = params["goal"]["title"].to_s
      @databaseGoal.save
    end
    
    if (@databaseGoal.description.to_s != params["goal"]["description"].to_s) 
      @databaseGoal.description = params["goal"]["description"].to_s
      @databaseGoal.save
    end
    
    currentMilestones = params["goal"]["milestones_attributes"]

    if (currentMilestones != nil)
      # delete out goals from originalGoal that were removed
      # from the form
      @databaseGoal.milestones.each do | milestone |
        foundKeyValue = nil
        foundValue = nil

        currentMilestones.each do | key, value |
          if (value["id"].to_i() == milestone.id)
            foundKeyValue = key
            foundValue = value
            break
          end
        end
      
        if (foundValue == nil)
          # if not found in form, remove from database
          milestone.destroy()
        else
          # remove the id key since updating the id is a no-no
          tempFoundValue = Hash.new(foundValue)
          tempFoundValue.delete("id")
        
          # update the position
          tempFoundValue["position"] = foundKeyValue.to_i()

          # if found, update database with values from the form
          milestone.update_attributes(tempFoundValue)
        end
      end

      # loop through milestones in params and create new
      # database data
      currentMilestones.each do | key, value |
        begin
          foundMilestone = @databaseGoal.milestones.find(value["id"].to_i())
          foundMilestone.update_attributes(value)
        rescue
          newMilestone = @databaseGoal.milestones.build(value)
          newMilestone.position = key.to_i()
          newMilestone.save()
        end
      end
    else 
      # user deleted all milestone
      @databaseGoal.milestones.each do | milestone |
        milestone.destroy()
      end
    end
    
    redirect_to user_goal_path(current_user.username, @databaseGoal.title)
  end
  
  private

    def authorized_user
      @goal = current_user.goals.find_by_title(params[:id])
      redirect_to root_path if @goal.nil?
    end

end
