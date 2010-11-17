require 'faker'

Factory.define :user do |user|
  user.first_name            { Faker::Name.first_name }
  user.second_name           { Faker::Name.last_name }
  user.email                 { Faker::Internet.email }
  user.birth_date            { Date.new(1940 + rand(60),1 + rand(11),1 + rand(27))}
  user.password              "foobar"
  user.password_confirmation { |u| u.password }
end

Factory.define :group do |group|
  group.name            { Faker::Company.name+" Project" }
  group.group_type      "PROJECT"
  group.citation        { Faker::Company.catch_phrase }
  group.citation_author { Faker::Name.name }
  group.client          { Faker::Company.name }
  group.web_page        { "http://" + Faker::Internet.domain_name }
end
