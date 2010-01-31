# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def owner?
    @teacher.id == current_user.id
  end  
end
