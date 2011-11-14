class UserGoalRelationship < ActiveRecord::Base
	attr_accessible :goal_id
  
  belongs_to :user_id, :class_name => "User"
  belongs_to :goal_id, :class_name => "Goal"
  
  validates :user_id, :presence => true
  validates :goal_id, :presence => true
end