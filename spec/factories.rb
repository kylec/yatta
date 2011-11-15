# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "mother"
  user.username              "mothera"
  user.email                 "mother@dood.com"
  user.password              "doddood"
  user.password_confirmation "doddood"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :username do |n|
  "mothera-#{n}"
end
