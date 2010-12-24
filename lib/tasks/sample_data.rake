require 'faker'

namespace :db do
  desc "Fill db with sample data"
  
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_groups
    make_roles
    make_involvements
  end
end

def make_users
  default = User.create!(:first_name => "John",
                         :second_name => "Doe",
                         :about_me => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
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

  User.create!(:first_name => "Up",
               :second_name => "Stairs",
               :email => "upstairs@upstairs.com",
               :password => "upstairs",
               :password_confirmation => "upstairs",
               :nickname => "upstairs",
               :birth_date => Date.new(1972,2,29))
                
  90.times do
    first_name  = Faker::Name.first_name
    second_name = Faker::Name.last_name
    email       = Faker::Internet.email
    birth_date  = Date.new(1940 + rand(60),1 + rand(11),1 + rand(27))

    User.create!(:first_name => first_name,
                 :second_name => second_name,
                 :about_me => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                 :email => email,
                 :birth_date => birth_date,
                 :password => "foobar",
                 :password_confirmation => "foobar")
  end  
end

def make_groups
  group = Group.create!(:name => "Upstairs",
                        :group_type => "PROJECT",
                        :citation => "Imagination is more important than knowledge.",
                        :citation_author => "Albert Einstein",
                        :aim_of_project => "Create small company corporate social network.",  
                        :client => "Open source project",
                        :web_page => "http://sample_app.com")
  10.times do |n|                      
    Group.create!(:name => Faker::Company.name+" Project",
                  :group_type => "PROJECT",
                  :citation => Faker::Company.catch_phrase,
                  :citation_author => Faker::Name.name,
                  :aim_of_project => "",  
                  :client => Faker::Company.name,
                  :web_page => "http://" + Faker::Internet.domain_name)    
  end
end

def make_roles
  attr = {:name       => "C++ Developer",
          :tech       => "C++",                 # both may be replaced with Name
          :role_type  => "Developer",      # both may be replaced with Name
          :area       => "Technical" }
  Role.create!(attr)
  Role.create!(attr.merge(:name => "Ruby Developer", :tech => "Ruby"))
  Role.create!(attr.merge(:name => "PLSQL Developer", :tech => "PLSQL"))
  Role.create!(attr.merge(:name => "Web Developer", :tech => "HTML, CSS"))
  Role.create!(attr.merge(:name => "Java Script Developer", :tech => "Java Script"))
  Role.create!(attr.merge(:name => "Database Administrator", :tech => "Oracle", :role_type => "Administrator"))                      
  Role.create!(attr.merge(:name => "System Administrator", :tech => "Linux", :role_type => "Administrator"))                      
  Role.create!(attr.merge(:name => "Project Manager", :tech => "", :role_type => "Manager"))                      

end

def make_involvements 
  users = User.all
  groups = Group.all
  roles = Role.all
  statuses = ["Senior", "Master", "Junior"]
  
  
  puts "Users: #{users.length}"
  puts "Groups: #{groups.length}"
  puts "Roles: #{roles.length}"
  
  users.each do |user| 
    attrs = {:user_id => user.id,
             :status =>  statuses[rand(statuses.length)], 
             :role_id => roles[rand(roles.length)].id, 
             :start_date => Date::strptime("20100101","%Y%m%d"),
             :end_date => nil,
             :edited_by => "Alex"}
    groups[rand(groups.size)].involvements.create!(attrs)
  end
end

