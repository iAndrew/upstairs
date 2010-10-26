class UserInterest < ActiveRecord::Base
  attr_accessible :interest
  
  belongs_to :user
end
