require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  
  has_many :subjects, :foreign_key => "teacher_id", :dependent => :destroy

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message

  validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :role



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    return nil if login.blank? || password.blank?
    u = find_by_login(login.downcase) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end
  
  def self.find_or_create name
    User.find_by_name(name) || create_student_user(name)    
  end                                  
  
  def self.create_student_user name
    login = Digest::SHA1.hexdigest(name)
    User.create(:login => login, :name => name, :role => Role::STUDENT,
      :email => "#{login}@email.com", :password => "fake_password", :password_confirmation => "fake_password")    
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def admin?
    is_in_role? Role::ADMIN
  end       
  
  def teacher?          
    is_in_role? Role::TEACHER
  end       
  
  def student?              
    is_in_role? Role::STUDENT
  end    

  def is_in_role? role_id
    self.role == role_id
  end  

  # def to_param
  #   self.login
  # end
  
  protected
end

class Role
  STUDENT = 0
  TEACHER = 1
  ADMIN = 2  
end