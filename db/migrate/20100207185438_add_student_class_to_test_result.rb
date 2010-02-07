class AddStudentClassToTestResult < ActiveRecord::Migration
  def self.up
    change_table(:test_results) do |t|
      t.string :student_class
    end
  end

  def self.down
    change_table(:test_results) do |t|
      t.remove :student_class
    end
  end
end
