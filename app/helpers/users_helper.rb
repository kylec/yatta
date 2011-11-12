module UsersHelper
  def profilePicture
    if @user.profile_picture == NIL then
      picturePath = "defaultProfilePicture.png"
    else
      picturePath = @user.profile_picture
    end
    
    image_tag(picturePath, :alt =>"Profile Picture", :class => "round", :width => "160", :height => "80")
  end
end
