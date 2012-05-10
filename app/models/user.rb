# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation,
                  :username, :profile_picture

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	has_many :goals, :dependent => :destroy # refers to created goals
	has_many :user_goal_relationships, :foreign_key => "user_id", :dependent => :destroy
  
  has_many :workingGoals, :through => :user_goal_relationships, :source => :goal
  													 
  validates :name, :presence => true,
                   :length   => { :maximum => 50 }
  validates :email, :presence   => true,
                    :format     => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  # Automatically create the virtual attribute 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
  validates :username, :presence => true,
                       :length   => { :maximum => 50 },
                       :uniqueness => { :case_sensitive => false }

  before_save :encrypt_password

  # Return true if the user's password matches the submitted password.
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def User.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def User.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def work! (workingGoal)
    user_goal_relationships.create!(:goal_id => workingGoal.id)
  end

  def stopWork! (workingGoal)
    user_goal_relationships.find_by_goal_id(workingGoal).destroy
  end

  def working? (workingGoal)
    user_goal_relationships.find_by_goal_id(workingGoal)
  end

  def created? (createdGoal)
    begin
      goals.find(createdGoal)
    rescue
      false
    end
  end

  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
