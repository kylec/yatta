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
    image_tag("logo.bmp", :alt =>"Goal App", :class => "round")
  end
end
