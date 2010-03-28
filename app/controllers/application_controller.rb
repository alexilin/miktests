# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  protected
                                    
  def load_teacher                                               
    @teacher = User.find params[:user_id], :conditions => ["role = ?", Role::TEACHER]
  end

  def load_subject                                               
    @subject = Subject.find params[:subject_id]
  end
  
  def only_for_admins
    return if logged_in? && current_user.admin?

    store_location
    redirect_to(login_path)
  end
  
  def only_for_owners
    return if logged_in? && current_user.teacher? && current_user.id == @teacher.id 

    store_location
    redirect_to(login_path)
  end                
    
end
