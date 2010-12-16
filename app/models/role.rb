# == Schema Information
# Schema version: 20101118183705
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  tech       :string(255)
#  role_type  :string(255)
#  area       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  attr_accessible :name, :tech, :role_type, :area
  validates :name, :presence => true, :uniqueness => true
  validates :area, :presence => true
  
  
  
end
