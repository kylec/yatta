module UsersHelper
  def profilePicture
    if @user.profile_picture == NIL then
      picturePath = "UserProfileImages/1.jpg"
    else
      picturePath = @user.profile_picture
    end
    
    image_tag(picturePath, :alt =>"Profile Picture", :width => "160", :height => "200")
  end
end
