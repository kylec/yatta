def index
@milestones = Milestone.order('milestones.position ASC')
end

def sort
@milestones = milestone.all
@milestones.each do |milestone|
milestone.position = params['milestone'].index(milestone.id.to_s) + 1
milestone.save
end

render :nothing => true
end
