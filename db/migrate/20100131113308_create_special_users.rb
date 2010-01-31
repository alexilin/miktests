class CreateSpecialUsers < ActiveRecord::Migration
  def self.up
    change_table("users") do |t|
      t.string :role 
    end             
    
    User.create :login => 'alex.ilin', :name => "Alex Ilin", :email => "alex.a.ilin@gmail.com", 
      :password => "initial_password", :password_confirmation => "initial_password", :role => "admin"
  end

  def self.down
    change_table("users") do |t|
      t.remove :role 
    end
    
    User.delete_all("login = 'alex.ilin'")
  end
end
