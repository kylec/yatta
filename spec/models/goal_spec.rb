require 'spec_helper'

describe Goal do
before(:each) do
    @user = Factory(:user)
    @attr = { :schedule => "path to XML" }
  end

  it "should create a new instance given valid attributes" do
    @user.goals.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @goal = @user.goals.create(@attr)
    end

    it "should have a user attribute" do
      @goal.should respond_to(:user)
    end

    it "should have the right associated user" do
      @goal.user_id.should == @user.id
      @goal.user.should == @user
    end
  end
  
  describe "goal associations" do

    before(:each) do
      @user = User.create(@attr)
    end

    it "should have a goals attribute" do
      @user.should respond_to(:goals)
    end
  end
  
  describe "validations" do

    it "should require a user id" do
      Goal.new(@attr).should_not be_valid
    end

    it "should require nonblank schedule path" do
      @user.goals.build(:schedule => "  ").should_not be_valid
    end
  end
end
