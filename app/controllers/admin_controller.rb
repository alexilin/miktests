class AdminController < ApplicationController

  before_filter :only_for_admins
  
  def index
    @teachers = User.all(:conditions => ["role = ?", Role::TEACHER])
  end      
  
  def new_teacher
    @teacher = User.new
  end       
  
  def create_teacher
    @teacher = User.new(params[:teacher].merge(:role => Role::TEACHER) )
    success = @teacher && @teacher.save
    if success && @teacher.errors.empty?
      redirect_to :action => "index"
    else
      render :action => 'new_teacher'
    end    
  end
  
  def edit_teacher
    @teacher = User.find(params[:id])
  end       

  def update_teacher
    @teacher = User.find(params[:id])
    if @teacher.update_attributes(params[:teacher])
      redirect_to :action => "index"
    else
      render :action => 'edit_teacher'
    end    
  end       

  def delete_teacher
    @teacher = User.find(params[:id])   
    @teacher.destroy
    redirect_to :action => "index"     
  end       
  
end
