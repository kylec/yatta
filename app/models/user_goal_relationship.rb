class UserGoalRelationship < ActiveRecord::Base
	attr_accessible :goal_id
  
  belongs_to :user
  belongs_to :goal

  has_many :user_goal_milestone_relationships, :foreign_key => "user_goal_relationship_id", :dependent => :destroy
  has_many :user_goal_comment_relationships, :foreign_key => "user_goal_relationship_id", :dependent => :destroy
  
  validates :user_id, :presence => true
  validates :goal_id, :presence => true

  def hasMilestone? (milestoneCheck)
    user_goal_milestone_relationships.find_by_milestone_id(milestoneCheck)
  end

  def complete! (milestoneCheck)
    user_goal_milestone_relationships.create!(:milestone_id => milestoneCheck.id)
  end

  def incomplete! (milestoneCheck)
    user_goal_milestone_relationships.find_by_milestone_id(milestoneCheck).destroy
  end

end