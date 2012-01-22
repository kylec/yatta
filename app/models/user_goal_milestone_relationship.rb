class UserGoalMilestoneRelationship < ActiveRecord::Base
  attr_accessible :user_goal_relationship_id, :milestone_id

  belongs_to :user_goal_relationship
end
