require 'faker'

Factory.define :user do |user|
  user.email                 { Faker::Internet.email }
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :group do |group|
  group.name            { Faker::Company.name }
  group.group_type      "PROJECT"
  group.citation        { Faker::Company.catch_phrase }
  group.citation_author { Faker::Name.name }
  group.client          { Faker::Company.name }
  group.web_page        { "http://" + Faker::Internet.domain_name }
end

