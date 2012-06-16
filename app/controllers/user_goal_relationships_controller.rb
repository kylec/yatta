class UserGoalRelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @goal = Goal.find_by_id(params[:goal_id])
    current_user.work!(@goal)
    respond_to do |format|
      format.html { redirect_to user_goal_path(current_user.username, @goal.title) }
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