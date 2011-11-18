require 'spec_helper'

describe GoalsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end
  
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = {:title => "", :description => ""}
      end

      it "should not create a goal" do
        lambda do
          post :create, :newgoal => @attr
        end.should_not change(Goal, :count)
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :title => "test", :description => "test description", 
                      "0"=>{:title =>"1", :description => "desc2"} 
                }
      end

      it "should create a goal" do
        lambda do
          post :create, :newgoal => @attr
        end.should change(Goal, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, :newgoal => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :newgoal => @attr
        flash[:success].should =~ /goal created/i
      end
    end
  end
end
