class Answer < ActiveRecord::Base
  include Uploads
    
  belongs_to :question
  
  def image_file= file                                        
    return unless file && file.respond_to?(:original_filename)
    self.image_url = save_uploaded_file file, :to => "answers"
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
