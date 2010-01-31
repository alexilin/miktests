class CreateTests < ActiveRecord::Migration
  def self.up
    create_table :tests do |t|
      t.integer :subject_id
      t.string  :title      
      t.timestamps
    end
    
    create_table :questions do |t|
      t.integer :test_id
      t.text    :question            
      t.timestamps
    end           

    create_table :answers do |t|
      t.integer :question_id
      t.text    :answer
      t.boolean :correct                  
      t.timestamps
    end

    create_table :user_answers do |t|
      t.integer :user_id
      t.integer :test_id
      t.integer :question_id
      t.integer :answer_id
      t.boolean :correct                  
      t.timestamps
    end

    create_table :test_results do |t|
      t.integer :test_id             
      t.integer :user_id
      t.integer :correct_count
      t.integer :incorrect_count
      t.timestamps
    end        
  end

  def self.down
    drop_table :tests
    drop_table :questions
    drop_table :answers
    drop_table :user_answers
    drop_table :test_results
  end
end
