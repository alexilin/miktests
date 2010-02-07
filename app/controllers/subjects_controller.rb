class SubjectsController < ApplicationController

  before_filter :load_teacher
  before_filter :only_for_owners, :except => :dashboard
  
  def dashboard
    @subjects = @teacher.subjects.all
  end
  
  # GET /subjects
  # GET /subjects.xml
  def index
    @subjects = @teacher.subjects.all
  end

  # # GET /subjects/1
  # # GET /subjects/1.xml
  # def show
  #   @subject = @teacher.subjects.find_by_id(params[:id])
  # end

  # GET /subjects/new
  # GET /subjects/new.xml
  def new
    flash[:error] = ""
    @subject = Subject.new
  end

  # GET /subjects/1/edit
  def edit
    @subject = current_user.subjects.find_by_id(params[:id])
  end

  # POST /subjects
  # POST /subjects.xml
  def create
    @subject = current_user.subjects.new(params[:subject])
    
    if !@subject.title.empty? && @subject.save
      flash[:notice] = 'Subject was successfully created.'
      redirect_to user_subjects_path
    else                                                  
      flash[:error] = 'Please enter subject title'
      render :action => "new"
    end
  end

  # PUT /subjects/1
  # PUT /subjects/1.xml
  def update
    @subject = current_user.subjects.find_by_id(params[:id])

    if !params[:subject][:title].empty? && @subject.update_attributes(params[:subject])
      redirect_to user_subjects_path
    else                                          
      flash[:error] = 'Please enter subject title'
      render :action => "edit"
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.xml
  def destroy
    @subject = current_user.subjects.find_by_id(params[:id])
    @subject.destroy
    redirect_to user_subjects_path
  end
end
