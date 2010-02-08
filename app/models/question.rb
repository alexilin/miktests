class Question < ActiveRecord::Base
  include Uploads
    
  belongs_to :test
  has_many :answers, :dependent => :destroy
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:answer].blank? }, :allow_destroy => true

  def image_file= file                                        
    return unless file && file.respond_to?(:original_filename)
    self.image_url = save_uploaded_file file, :to => "questions"
  end
  
  def image_url= url
    if url.blank?   
      remove_uploaded_file self.image_url
    end                                  
    super url
  end
  
  def before_destroy 
    remove_uploaded_file self.image_url    
  end
end
