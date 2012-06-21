class UserGoalCommentRelationshipsController < ApplicationController

  def create
    @userGoalRelationship = UserGoalRelationship.find_by_id(params[:user_goal_comment_relationship][:user_goal_relationship_id])
    @comment = @userGoalRelationship.user_goal_comment_relationships.build(params[:user_goal_comment_relationship]);

    if @comment.save
      respond_to do |format|
        format.html { redirect_to user_goal_path(@userGoalRelationship.user.username, @userGoalRelationship.goal.title) }
        format.js
      end
    else
      flash.now[:error] = "Error saving post."
    end
  end

  def destroy
    @comment = UserGoalCommentRelationship.find_by_id(params[:id]);
    puts @comment.class
    @userGoalRelationship = @comment.user_goal_relationship
    @username = @userGoalRelationship.user.username
    @goalTitle = @userGoalRelationship.goal.title
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to user_goal_path(@username, @goalTitle) }
      format.js
    end
  end

end