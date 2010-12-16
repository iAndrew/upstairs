# == Schema Information
# Schema version: 20101118183705
#
# Table name: groups
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  group_type      :string(255)
#  citation        :string(255)
#  citation_author :string(255)
#  aim_of_project  :string(255)
#  client          :string(255)
#  web_page        :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Group < ActiveRecord::Base
  # citation should be removed, it sucks IMO -- Andrew
  
  attr_accessible :name, :group_type, :citation, :citation_author, 
                  :aim_of_project, :client, :web_page   
  
  url_regexp = /((http|https):\/\/\w+.\w+)|^$/i  #the most simple url validator
  
  validates :name, :presence => true, :uniqueness => true,
            :length => { :minimum => 8, :maximum => 50 }
  validates :group_type, :presence => true, :inclusion => ["PROJECT", "GROUP"]
  validates :citation, :presence => true, :unless => :citation_author_empty? 
  validates :web_page, :length => { :maximum => 50 }, :format => { :with => url_regexp }
  validates :client, :presence => true, :length => { :minimum => 4, :maximum => 50 }
  
  def citation_author_empty?
    citation_author.empty?
  end
  
  def participants 
    self.users.group("email, first_name, second_name").order("first_name, second_name")
  end
  
  
  has_many :involvements, :dependent => :destroy
  has_many :current_involvements, :class_name => "Involvement", :conditions => ['end_date is null']
  
  has_many :users, :through => :involvements, :source => :user
  
#  def involve (args)
  #   self.involvements.create(args)
  # end 
  # 
  # def terminate_involvement (args)
  #   self.involvements.create(args)
  # end 
end
