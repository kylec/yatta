require 'spec_helper'

describe PagesController do
  render_views
    
  describe "GET 'home'" do
  
    before(:each) do 
      @base_title = "Goal_App"
      get 'home'
    end
    
    it "should be successful" do
      response.should be_success
    end
  
	it "should have title" do
	  response.should have_selector("title", :content => "Goal_App")
	end
	
	it "should have logo image" do
	  response.should have_selector("img", :src => "/assets/logo.png")
	end
	
    it "should have tag line" do 
    	response.should have_selector("h1", :content => "Achieve your goals")
    end
    
    it "should have mission statement" do 
    	response.should have_selector("h2",
    	:content => "A community for creating, sharing, and pursuing your goals")
    end
    
    it "should have login field: Email" do 
    	response.should have_selector("input", :placeholder => "Email")
    end
    
    it "should have password field: Password" do 
    	response.should have_selector("input", :placeholder => "Password")
    end
    
    it "should have signin button" do 
    	response.should have_selector("input", :type => "submit")
    end
    
    it "should have forgot password link" do 
    	response.should have_selector("a", :href => forgotpassword_path,
    	:content => "Forgot password?")
    end
	
	it "should have sign up link" do 
		response.should have_selector("a", :href => signup_path,
		:content => "Sign up")
	end
	
	it "should have search field" do
		response.should have_selector("input", :placeholder => "Find your goal")
	end
	
    it "should have search field button" do
    	response.should have_selector("input", :type => "submit")
    end
    
    it "should have about page" do
      response.should have_selector("a", :href => about_path,
      :content => "About")
    end
    
    it "should have contact page" do
      response.should have_selector("a", :href => contact_path,
      :content => "Contact")
    end
    
    it "should have privacy page" do
      response.should have_selector("a", :href => privacy_path,
      :content => "Privacy")
    end
    
    it "should have use terms page" do
      response.should have_selector("a", :href => terms_path,
      :content => "Terms")
    end
  end
end
