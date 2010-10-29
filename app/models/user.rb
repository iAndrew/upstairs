# == Schema Information
# Schema version: 20101026154531
#
# Table name: users
#
#  id          :integer         not null, primary key
#  email       :string(255)
#  pass        :string(255)
#  salt        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  first_name  :string(255)
#  second_name :string(255)
#  birth_date  :date
#  about_me    :text
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :nickname, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, :format => { :with => email_regex }, :uniqueness => { :case_sensetive => false }
  validates :password, :confirmation => true, :length => { :within => 6..40 }, :if => :password_required?
  
  before_save :encrypt_password
  
  has_many :authorizations
  
  has_many :user_interests
  
  has_one :user_contact
  
  def has_password?(submitted_password)
    pass == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def password_required?
    authorizations.empty? || !password.blank?
  end
  
  def apply_omniauth(hash)
    self.nickname = hash['user_info']['nickname']
    authorizations.build(:provider => hash['provider'], :uid => hash['uid'])
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
