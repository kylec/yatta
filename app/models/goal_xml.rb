class GoalXML
  include ActiveModel::Validations

  attr_accessor :title, :description, :milestones
  attr_accessible :title, :description, :milestones

  
end