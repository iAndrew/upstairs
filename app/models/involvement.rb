class Involvement < ActiveRecord::Base
  
  attr_accessible :user_id, :status, :role_id, :start_date, :end_date, :edited_by
  
  belongs_to :group
  belongs_to :user
  belongs_to :role
  
  validates :group_id, :presence => true
  validates :user_id, :presence => true
#  validates :status, :presence => true

  validates :start_date, :presence => true
  validates :edited_by, :presence => true
    
  def role_name_full
    _role_name = self.status
    _role_name += " " unless self.status.empty?
    _role_name += "#{role_name}"
  end  
  
  def role_name
    self.role.name if self.role_id
  end  

  def role_tech
    self.role.tech if self.role_id
  end
    
end
