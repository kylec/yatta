class MilestoneXML
  include ActiveModel::Validations

  attr_accessor :title, :description
  attr_accessible :title, :description

  
end
