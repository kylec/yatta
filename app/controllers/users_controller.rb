class UsersController < ApplicationController
   before_filter :authenticate, :except => [:show, :new, :create]
   before_filter :correct_user, :only => [:edit, :update]

  def show
    @user = User.find(params[:id])
    @title = @user.name
    puts params[:goalDisplayOption]

    if (!params.has_key?(:goalDisplayOption) || params[:goalDisplayOption] == "All")
      @goals= @user.goals
      @workingGoals = @user.workingGoals
      @totalGoals = Hash.new()

      @goals.each do | goal |
        @totalGoals[goal.id] = {:g => goal, :w => false}
      end

      @workingGoals.each do | goal |
        @totalGoals[goal.id] = {:g => goal, :w => true}
      end
    elsif (params[:goalDisplayOption] == "Active")
      @workingGoals = @user.workingGoals
      @totalGoals = Hash.new()
      
      @workingGoals.each do | goal |
        @totalGoals[goal.id] = {:g => goal, :w => true}
      end
    elsif (params[:goalDisplayOption] == "Created")
      @goals= @user.goals
      @workingGoals = @user.workingGoals
      @totalGoals = Hash.new()

      @goals.each do | goal |
        @totalGoals[goal.id] = {:g => goal, :w => false}
      end

      @workingGoals.each do | goal |
        if (@totalGoals.has_key?(goal.id))
          @totalGoals[goal.id] = {:g => goal, :w => true}
        end
      end
    end
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Goal App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def showAllGoals
    redirect_to :controller => "users", :action => "show", :id => current_user.id, :goalDisplayOption=>"All"
  end

  def showActiveGoals
    redirect_to :controller => "users", :action => "show", :id => current_user.id, :goalDisplayOption=>"Active"
  end

  def showCreatedGoals
    redirect_to :controller => "users", :action => "show", :id => current_user.id, :goalDisplayOption=>"Created"
  end
end
