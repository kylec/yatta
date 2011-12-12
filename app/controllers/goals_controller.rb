class GoalsController < ApplicationController
  require 'builder'

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def new
    @goal = Goal.new
    3.times do |i| 
      milestone = @goal.milestones.build()
    end
    @title = GoalsHelper::CREATE_TITLE
  end

  def create
    index = 1 
  
    @goal = Goal.new(params[:goal])
   
    @goal.milestones.each do |i|
      i.position = index
      index += 1
    end
   
    if @goal.save
      flash[:notice] = "Successfully created goal."
      redirect_to @goal
    else
      render :action => 'new'
    end
  end

  def destroy
    
  end
  
  def show
    @title = "Goal"
    @goal = Goal.find(params[:id])
    @goal.milestones.sort_by!(&:position)
  end

  def edit
    @title = GoalsHelper::EDIT_TITLE
    @goal = Goal.find(params[:id])
    @goal.milestones.sort_by!(&:position)
  end

  def update
    # get the database goal data
    @databaseGoal = Goal.find(params[:id])

    # delete out goals from originalGoal that were removed
    # from the form
    @databaseGoal.milestones.each do | milestone |
      foundValue = nil;
      params["goal"]["milestones_attributes"].each do | key, value |
        if (value["id"].to_i() == milestone.id)
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
        # if found, update database with values from the form
        milestone.update_attributes(tempFoundValue)
      end
    end

    # loop through milestones in params and create new
    # database data
    paramsIndex = 1
    params["goal"]["milestones_attributes"].each do | key, value |
      begin
        puts value["id"].to_i()
        @databaseGoal.milestones.find(value["id"].to_i())
      rescue
        newMilestone = @databaseGoal.milestones.build(value);
        newMilestone.position = paramsIndex;
        newMilestone.save()
      end
      paramsIndex += 1
    end

    redirect_to @databaseGoal
  end

  private

    def authorized_user
      @goal = current_user.goals.find_by_id(params[:id])
      redirect_to root_path if @goal.nil?
    end

end
