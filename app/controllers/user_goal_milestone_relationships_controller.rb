class UserGoalMilestoneRelationshipsController < ApplicationController

  def create
    @milestone = Milestone.find(params[:user_goal_milestone_relationship][:milestone_id])
    @userGoalRelationship = UserGoalRelationship.find(params[:user_goal_milestone_relationship][:user_goal_relationship_id])
    @userGoalRelationship.complete!(@milestone)
    @goal = @userGoalRelationship.goal
    redirect_to user_goal_path(current_user.username, @goal.title)
  end

  def destroy
    @milestone = UserGoalMilestoneRelationship.find(params[:id]).milestone
    @userGoalRelationship = UserGoalRelationship.find(params[:user_goal_milestone_relationship][:user_goal_relationship_id])
    @userGoalRelationship.incomplete!(@milestone)
    @goal = @userGoalRelationship.goal
    redirect_to user_goal_path(current_user.username, @goal.title)
  end

end