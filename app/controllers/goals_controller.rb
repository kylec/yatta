class GoalsController < ApplicationController
  def new
    #@goal = Goal.new
    @title = "Create Goal"
  end

  def create
    puts "XXXXXXXXXXXXXXXxx"
    puts params[:newgoal]["0"][:title]
    puts params[:newgoal]["0"][:description]
    puts params[:newgoal]["1"][:title]
    puts params[:newgoal]["1"][:description]
    puts params[:newgoal]["2"][:title]
    puts params[:newgoal]["2"][:description]
    render 'new'
  end

  def destroy
    
  end
end
