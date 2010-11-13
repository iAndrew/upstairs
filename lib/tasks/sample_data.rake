require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
  end
end

def make_users
  default = User.create!(:first_name => "John",
                         :second_name => "Doe",
                         :email => "john.doe@example.com",
                         :password => "foobar",
                         :password_confirmation => "foobar",
                         :birth_date => Date.new(1950,4,15))

  # User with leap year birthdate
  leap_user = User.create!(:first_name => "Jane",
                           :second_name => "Doe",
                           :email => "jane.doe@example.com",
                           :password => "foobar",
                           :password_confirmation => "foobar",
                           :birth_date => Date.new(1972,2,29))

  25.times do
    first_name  = Faker::Name.first_name
    second_name = Faker::Name.last_name
    email       = Faker::Internet.email
    birth_date  = Date.new(1940 + rand(60),1 + rand(11),1 + rand(27))

    User.create!(:first_name => first_name,
                 :second_name => second_name,
                 :email => email,
                 :birth_date => birth_date,
                 :password => "foobar",
                 :password_confirmation => "foobar")
  end
end
