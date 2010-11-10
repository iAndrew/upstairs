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
  User.create!({:email => "upstairs@upstairs.com",
                :password => "upstairs",
                :password_confirmation => "upstairs",
                :nickname => "upstairs"})
  90.times do |n|
    email = "example#{n+1}@upstairs.com" 
    password = "password"
    name = Faker::Name.name
    User.create!( :email => email,
                  :password => password,
                  :password_confirmation => password,
                  :nickname => name.downcase.gsub(" ", ""))
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