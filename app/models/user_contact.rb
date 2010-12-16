# == Schema Information
# Schema version: 20101118183705
#
# Table name: user_contacts
#
#  id         :integer         not null, primary key
#  category   :string(255)
#  value      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserContact < ActiveRecord::Base
  attr_accessible :category, :value
  
  belongs_to :user
  
end
