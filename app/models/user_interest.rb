# == Schema Information
# Schema version: 20101026154531
#
# Table name: user_interests
#
#  id         :integer         not null, primary key
#  interest   :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UserInterest < ActiveRecord::Base
  attr_accessible :interest
  
  belongs_to :user
end
