require 'ar-extensions'
require 'ar-extensions/adapters/mysql'
require 'ar-extensions/import/mysql'

class TestsController < ApplicationController

  before_filter :load_teacher, :load_subject
  before_filter :only_for_owners, :except => [:dashboard, :before_pass, :pass, :result]
  
  def dashboard
    @tests = @subject.tests.all
  end

  # GET /tests
  # GET /tests.xml
  def index
    @tests = @subject.tests.all
  end

  # # GET /tests/1
  # # GET /tests/1.xml
  # def show
  #   @test = @subject.tests.find_by_id(params[:id])        
  # end                                           

  def before_pass                                         
    @test = @subject.tests.find_by_id(params[:id])        
    if request.post?
      @student_name = params[:test][:student_name]
      @student_class = params[:test][:student_class]      
      if @test.authenticate(params[:test][:test_password]) && !@student_name.blank? && !@student_class.blank?
        session["test#{@test.id}"] = @test.crypted_password        
        session[:student_class] = @student_class
        student = User.find_or_create @student_name        
        self.current_user = student
        redirect_to :action => 'pass'
      else
        flash[:notice] = "Please enter your name, class and test access password"
      end      
    end
  end

  USER_ANSWER_COLUMNS = [:user_id, :test_id, :question_id, :answer_id, :correct, :created_at, :updated_at]
  UPDATE_USER_ANSWER_COLUMNS = [:answer_id, :correct, :updated_at]

  TEST_RESULT_COLUMNS = [:user_id, :test_id, :student_class, :correct_count, :incorrect_count, :created_at, :updated_at]
  UPDATE_TEST_RESULT_COLUMNS = [:student_class, :correct_count, :incorrect_count, :updated_at]

  def pass        
    @test = @subject.tests.find_by_id(params[:id])        
    if_student_enters_access_psw? @test do 
      @qnumber = params[:q].to_i || 0           
      @answer_id = params[:answer]
      @test = @subject.tests.find_by_id(params[:id])    
      @qnumber = @test.questions.count - 1 if @qnumber >= @test.questions.count
      @question = @test.questions.all[@qnumber]
      @answer = @question.answers.find_by_id(@answer_id) if @answer_id

      if @answer                                
        UserAnswer.import(USER_ANSWER_COLUMNS, 
        [[current_user.id, @test.id, @question.id, @answer.id, @answer.correct, Time.now, Time.now]], 
        :validate => false, :timestamps => false,
        :on_duplicate_key_update => UPDATE_USER_ANSWER_COLUMNS)

        @qnumber += 1                      
        if @qnumber >= @test.questions.count           
          # test finished
          correct_count = TestResult.get_correct_count(current_user, @test)
          incorrect_count = TestResult.get_incorrect_count(current_user, @test)

          TestResult.import(TEST_RESULT_COLUMNS, 
          [[current_user.id, @test.id, session[:student_class], correct_count, incorrect_count, Time.now, Time.now]], 
          :validate => false, :timestamps => false,
          :on_duplicate_key_update => UPDATE_TEST_RESULT_COLUMNS)

          redirect_to result_user_subject_test_path(@teacher, @subject, @test)
        else
          redirect_to pass_user_subject_test_path(@teacher, @subject, @test, :q => @qnumber)
        end
      end                
    end
  end                    

  def result                                              
    @test = @subject.tests.find_by_id(params[:id])        
    @result = TestResult.find_by_user_id_and_test_id(current_user.id, @test.id)
  end

  def results
    @test = @subject.tests.find_by_id(params[:id])        
    @classes = TestResult.all(:conditions => ["test_id = ?",@test.id], :group => "student_class").map { |tr| tr.student_class }
  end

  def class_results    
    @test = @subject.tests.find_by_id(params[:id])        
    @results = TestResult.all(:conditions => ["test_id = ? and student_class = ?", @test.id, params[:class]])
    @results.sort! {|a,b| a.user.name <=> b.user.name }
  end     
              
  
  EXPORT_FILES_DIR = "#{RAILS_ROOT}/public/export/"
  def export_class_results                  
    class_name = params[:class]                     
    
    @test = @subject.tests.find_by_id(params[:id])        
    results = TestResult.all(:conditions => ["test_id = ? and student_class = ?", @test.id, class_name])
    results.sort! {|a,b| a.user.name <=> b.user.name }
                               
    test_name = @test.title      
    file_name = "#{test_name}-#{class_name}-results.csv" 
    file_path = File.join(EXPORT_FILES_DIR, file_name)
    File.open(file_path, "wb") do |f|
      f << "Student name,Class name,Test,Results\n"
      for result in results
        f << "#{result.user.name},#{class_name},#{test_name},#{result.percent}%\n"              
      end
    end
      
    send_file file_path, :type => "application/excel"#, :x_sendfile=>true
    # render :file => file_path, :layout => false
  end

  # GET /tests/new
  # GET /tests/new.xml
  def new
    @test = @subject.tests.new
    3.times do
      question = @test.questions.build
      4.times { question.answers.build }
    end
  end

  # GET /tests/1/edit
  def edit
    @test = @subject.tests.find_by_id(params[:id])
  end

  # POST /tests
  # POST /tests.xml
  def create
    @test = @subject.tests.new(params[:test])
    if @test.save
      redirect_to user_subject_tests_path
    else
      render :action => "new"
    end
  end

  # PUT /tests/1
  # PUT /tests/1.xml
  def update
    @test = @subject.tests.find_by_id(params[:id])
    if @test.update_attributes(params[:test])
      redirect_to user_subject_tests_path
    else
      render :action => "edit"
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.xml
  def destroy
    @test = Test.find_by_id(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to user_subject_tests_path }
      format.xml  { head :ok }
    end
  end

  private

  def if_student_enters_access_psw? test
    if session["test#{test.id}"] == test.crypted_password
      yield
    else
      redirect_to :action => "before_pass" 
    end
  end
end
