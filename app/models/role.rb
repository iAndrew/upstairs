class Role < ActiveRecord::Base
  attr_accessible :name, :tech, :role_type, :area
  validates :name, :presence => true, :uniqueness => true
  validates :area, :presence => true
  
  
  
end
