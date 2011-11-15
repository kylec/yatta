require 'spec_helper'

describe UserGoalRelationship do
  before(:each) do
    @user1 = Factory(:user)
    @user2 = Factory(:user, :username => Factory.next(:username), :email => Factory.next(:email))
    @attr = { :schedule => "path to XML" }
    @user2.goals.create!(@attr)
    user2goals = @user2.goals[0]
    puts user2goals.class
    @user_goal_relationship = @user1.user_goal_relationships.build(:goal_id => user2goals.id)
  end

  it "should create a new instance given valid attributes" do
    @user_goal_relationship.save!
  end
  
  describe "user_goal methods" do

    before(:each) do
      @user_goal_relationship.save
    end

    it "should have a user id" do
      @user_goal_relationship.should respond_to(:user_id)
    end

    it "should have the right user" do
      @user_goal_relationship.user_id.should == @user1
    end

    it "should have a working goal id" do
      @user_goal_relationship.should respond_to(:goal_id)
    end

    it "should have the right working goal" do
      @user_goal_relationship.goal_id.should == @user2.goals[0]
    end
  end
  
  describe "validations" do

    it "should require a user_id" do
      @user_goal_relationship.user_id = nil
      @user_goal_relationship.should_not be_valid
    end

    it "should require a goal_id" do
      @user_goal_relationship.goal_id = nil
      @user_goal_relationship.should_not be_valid
    end
  end
end
