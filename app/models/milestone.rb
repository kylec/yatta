class Milestone < ActiveRecord::Base
  attr_accessible :goal_id, :title, :description, :order
  acts_as_list
  
  belongs_to :goal

  validates :title, :presence => true,
                    :length   => { :maximum => 50 }
  validates :description, :length   => { :maximum => 150 }
  
  validates :order, :presence => true
end
