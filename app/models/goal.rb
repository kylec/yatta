class Goal < ActiveRecord::Base
	attr_accessible :user_id, :schedule
	belongs_to :user
	
	has_many :reverse_user_goal_relationships, :foreign_key => "goal_id",
                                   :class_name => "UserGoalRelationship",
                                   :dependent => :destroy
  has_many :workingUsers, :through => :reverse_user_goal_relationships, :source => :user_id
 
  validates :user_id, :presence => true
  validates :schedule, :presence => true
end
