class UserGoalCommentRelationships < ActiveRecord::Base
  attr_accessible :user_goal_relationship_id, :user_id, :comment

  belongs_to :user_goal_relationship
  belongs_to :user
  
  validates :user_goal_relationship_id, :presence => true,
  validates :user_id, :presence => true,
  validates :comment, :presence => true,
                      :length   => { :maximum => 150 }                    
end
