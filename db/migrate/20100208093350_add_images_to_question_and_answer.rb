class AddImagesToQuestionAndAnswer < ActiveRecord::Migration
  def self.up
    change_table(:questions) do |t|
      t.string :image_url                      
    end
    
    change_table(:answers) do |t|
      t.string :image_url                      
    end    
  end

  def self.down
    change_table(:questions) do |t|
      t.remove :image_url                      
    end
    
    change_table(:answers) do |t|
      t.remove :image_url                      
    end        
  end
end
