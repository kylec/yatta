module UsersHelper
  def profilePicture
    if @user.profile_picture == NIL then
      picturePath = "Cropped - Solid.png"
    else
      picturePath = @user.profile_picture
    end
    
    image_tag(picturePath, :alt =>"Profile Picture", :class => "round", :width => "160", :height => "160")
  end
end
