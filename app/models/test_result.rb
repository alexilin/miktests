class TestResult < ActiveRecord::Base
  belongs_to :user
  
  def self.get_correct_count user, test
    UserAnswer.count(:conditions => ["user_id = ? and test_id = ? and correct = ?", user.id, test.id, true])    
  end
  
  def self.get_incorrect_count user, test
    UserAnswer.count(:conditions => ["user_id = ? and test_id = ? and correct = ?", user.id, test.id, false])        
  end                       
  
  def percent
    (self.correct_count.to_f / (self.correct_count + self.incorrect_count) * 100).to_i
  end
end