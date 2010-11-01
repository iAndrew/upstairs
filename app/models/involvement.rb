class Involvement < ActiveRecord::Base
  
  attr_accessible :user_id, :status, :role_id, :start_date, :end_date, :edited_by
  
  belongs_to :group
  belongs_to :user
  belongs_to :role
  
  validates :group_id, :presence => true
  validates :user_id, :presence => true
  validates :status, :presence => true

  validates :start_date, :presence => true
  validates :edited_by, :presence => true
    
end
