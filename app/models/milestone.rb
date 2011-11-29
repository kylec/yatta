class Milestone < ActiveRecord::Base
  attr_accessible :goal_id, :title, :description
  
  belongs_to :goal

  validates :title, :presence => true,
                    :length   => { :maximum => 50 }
  validates :description, :length   => { :maximum => 150 }
end
