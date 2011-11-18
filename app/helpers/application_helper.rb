module ApplicationHelper
  def title
    base_title = "Goal_App"
    if @title.nil?
  	  base_title
    else
      @title
    end
  end
  
  def logo
    image_tag("logo.png", :alt =>"Goal App", :class => "round", :width => "160", :height => "80")
  end
end
