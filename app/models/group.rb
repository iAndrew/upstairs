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
  
end
