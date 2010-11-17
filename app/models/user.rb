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
  attr_accessible :first_name, :second_name, :email, :password, :password_confirmation, :birth_date
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, :format => { :with => email_regex }, :uniqueness => { :case_sensetive => false }
  validates :password, :confirmation => true, :length => { :within => 6..40 }, :if => :password_required?
  
  before_save :encrypt_password
  
  has_many :authorizations
  
  has_many :involvements, :dependent => :destroy
  has_many :current_involvements, :class_name => "Involvement", :conditions => ['end_date is null']
  
  has_many :groups, :through => :involvements, :source => :group

  has_many :interests, :class_name => "UserInterest"
  
  has_one :contact, :class_name => "UserContact"
  
  def full_name
    first_name + " " + second_name
  end
  
  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
  end
  
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
    authorizations.build(:provider => hash['provider'], :uid => hash['uid'])
  end
  
  def next_birthday
    year = Date.today.year
    mmdd = birth_date.strftime('%m%d')
    year += 1 if mmdd < Date.today.strftime('%m%d')
    mmdd = '0301' if mmdd == '0229' && !Date.parse("#{year}0101").leap?
    Date.parse("#{year}#{mmdd}")
  end
  
  def self.birthdays_around(range)
    dates = []
    range.each { |d| 
      dates << d.strftime('%m%d')      
    }
    dates << "0229" if !dates.include?("0229") && dates.include?("0228") && dates.include?("0301")
    User.find(:all, :conditions => [ "strftime('%m%d',birth_date) IN (?)", dates ])
  end
  
  def days_to_birthday
    (next_birthday-Date.today).to_i
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
