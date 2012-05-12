class UserGoalMilestoneRelationshipsController < ApplicationController

  def create
    @milestone = Milestone.find(params[:user_goal_milestone_relationship][:milestone_id])
    @userGoalRelationship = UserGoalRelationship.find(params[:user_goal_milestone_relationship][:user_goal_relationship_id])
    @userGoalRelationship.complete!(@milestone)
    @goal = @userGoalRelationship.goal
    redirect_to @goal
  end

  def destroy
    @milestone = UserGoalMilestoneRelationship.find(params[:id]).milestone
    @userGoalRelationship = UserGoalRelationship.find(params[:user_goal_milestone_relationship][:user_goal_relationship_id])
    @userGoalRelationship.incomplete!(@milestone)
    @goal = @userGoalRelationship.goal
    redirect_to @goal
  end

end