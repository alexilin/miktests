require 'digest/sha1'

class Test < ActiveRecord::Base  
  SALT = "long$alt2101"
  
  belongs_to :subject
  has_many :questions, :dependent => :destroy
  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:question].blank? }, :allow_destroy => true      
              
  def authenticate psw
    self.crypted_password == encrypt(psw)
  end        
   
 def password  
 end

 def password= psw
  self.crypted_password = encrypt(psw)
 end

 def encrypt(password)
   Digest::SHA1.hexdigest(password + SALT)
 end
 
end
