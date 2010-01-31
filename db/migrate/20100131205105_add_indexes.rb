class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :user_answers, [:user_id, :test_id, :question_id], :unique => true
    add_index :test_results, [:user_id, :test_id], :unique => true
  end

  def self.down
    remove_index :user_answers, [:user_id, :test_id, :question_id]
    remove_index :test_results, [:user_id, :test_id]
  end
end
