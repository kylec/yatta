class UsersController < ApplicationController
   before_filter :authenticate, :except => [:show, :new, :create]
   before_filter :correct_user, :only => [:edit, :update]
   
   def show
    @user = User.find(params[:id])
    @title = @user.name
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
end
