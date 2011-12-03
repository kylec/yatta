class GoalsController < ApplicationController
  require 'builder'

  before_filter :authenticate, :only => [:create, :destroy]
  before_filter :authorized_user, :only => :destroy

  def new
    @goal = Goal.new
    3.times do |i| 
      milestone = @goal.milestones.build()
      milestone.order = i
    end
    @title = "Create Goal"
  end

  def create
    index = 1 
  
    @goal = Goal.new(params[:goal])
   
    @goal.milestones.each do |i|
      i.order = index
      index += 1
    end
   
    if @goal.save
     puts "saving........"
       
      flash[:notice] = "Successfully created goal."
      redirect_to @goal
    else
      render :action => 'new'
    end
  end

  def destroy
    
  end
  
  def test
    @title = "test"
    @goal = Goal.find(37)
    if(@goal.nil?)
      puts "goal is nil "
    else 
      puts "goal is not nil"
    end
  end
  
  def show
    @title = "Goal"
    @goal = Goal.find(params[:id])
  end
  
  def prioritize_tasks
    @goal = Goal.find(params[:id])
    @goal.milestones.each do |milestone|
      milestone.order = params['milestone'].index(milestone.id.to_s) + 1
      milestone.save
    end
    render :nothing => true
  end

  private

    def authorized_user
      @goal = current_user.goals.find_by_id(params[:id])
      redirect_to root_path if @goal.nil?
    end

end
