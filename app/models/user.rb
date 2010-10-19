# == Schema Information
# Schema version: 20101019183408
#
# Table name: users
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  pass       :string(255)
#  salt       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  nickname   :string(255)
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :nickname, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  #validates :email, :format => { :with => email_regex }, :uniqueness => { :case_sensetive => false }
  #validates :password, :confirmation => true, :length => { :within => 6..40 }
  
  before_save :encrypt_password
  
  has_many :authorizations
  
  def has_password?(submitted_password)
    pass = encrypt(submitted_password)
  end
  
  def self.create_from_hash!(hash)
    create(:nickname => hash['user_info']['nickname'])
  end
  
  private  

    def encrypt_password
      self.salt = make_salt if new_record?
      self.pass = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end