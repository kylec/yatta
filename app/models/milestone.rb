class Milestone < ActiveRecord::Base
  attr_accessible :goal_id, :title, :description, :position
  
  belongs_to :goal

  has_many :reverse_user_goal_milestone_relationships, :foreign_key => "milestone_id",
                                   :class_name => "UserGoalMilestoneRelationship",
                                   :dependent => :destroy
                                   
  acts_as_list
  
  validates :title, :presence => true,
                    :length   => { :maximum => 50 }
  validates :description, :length   => { :maximum => 150 }
  
  validates :position, :presence => true
end
