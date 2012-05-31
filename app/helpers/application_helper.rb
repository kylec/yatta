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
    image_tag("logo-shrink.png", :alt =>"Goal App")
  end
end
