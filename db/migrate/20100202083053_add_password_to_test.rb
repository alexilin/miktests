class AddPasswordToTest < ActiveRecord::Migration
  def self.up    
    change_table(:tests) do |t|
      t.string :crypted_password, :limit => 40
      t.string :salt, :limit => 40
    end
  end

  def self.down
    change_table(:tests) do |t|
      t.remove :crypted_access_password, :salt
    end
  end
end
