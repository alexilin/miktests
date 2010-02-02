class WelcomeController < ApplicationController
  def index  
    @teachers = User.all(:conditions => ["role = ?", Role::TEACHER])
  end
end