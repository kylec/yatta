class Goal < ActiveRecord::Base
  acts_as_indexed :fields => [:title] 
	attr_accessible :user_id, :title, :description, :milestones_attributes
	belongs_to :user
	
	has_many :reverse_user_goal_relationships, :foreign_key => "goal_id",
                                   :class_name => "UserGoalRelationship",
                                   :dependent => :destroy
  has_many :workingUsers, :through => :reverse_user_goal_relationships, :source => :user_id
  has_many :milestones, :dependent => :destroy

  accepts_nested_attributes_for :milestones, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true

  validates :title, :presence => true,
                    :length   => { :maximum => 50 }
                    
  validates :description, :length   => { :maximum => 150 }
end
