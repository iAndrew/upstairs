# == Schema Information
# Schema version: 20101026154531
#
# Table name: user_contacts
#
#  id            :integer         not null, primary key
#  contact_type  :string(255)
#  contact_value :string(255)
#  user_id       :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class UserContact < ActiveRecord::Base
  attr_accessible :category, :value
  
  belongs_to :user
  
end
