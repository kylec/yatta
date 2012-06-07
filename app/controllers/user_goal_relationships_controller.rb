class UserGoalRelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @goal = Goal.find(params[:user_goal_relationship][:goal_id])
    current_user.work!(@goal)
    respond_to do |format|
      format.html { redirect_to @goal }
      format.js
    end
  end

  def destroy
    @goal = UserGoalRelationship.find(params[:id]).goal
    current_user.stopWork!(@goal)
    respond_to do |format|
      format.html { 
        redirect_to :controller => "users", :action => "show", :id => current_user.username
      }
      format.js
    end
  end
end