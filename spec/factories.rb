# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "dood"
  user.username              "doodie"
  user.email                 "dood@dood.com"
  user.password              "dooddood"
  user.password_confirmation "dooddood"
end