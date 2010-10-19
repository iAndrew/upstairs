require 'faker'

Factory.define :user do |user|
  user.email                 { Faker::Internet.email }
  user.password              "foobar"
  user.password_confirmation "foobar"
end