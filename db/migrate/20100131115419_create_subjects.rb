class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.integer :teacher_id
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :subjects
  end
end
