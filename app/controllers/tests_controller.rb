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
        student = User.find_or_create @student_name        
        self.current_user = student             
        create_test_session @test, student, @student_class        
        redirect_to :action => 'pass'
      else
        flash[:notice] = "Please enter your name, class and test access password"
      end      
    end
  end

  def pass        
    @show_header_banner = false
    
    @test = @subject.tests.find_by_id(params[:id])        
    if_student_enters_access_psw? @test do 
      # save answer if needed
      save_answer @test, test_session(@test)[:current_question], params[:answer]
             
      # show next question
      next_question = get_random_next_question_number @test
      if next_question   
        @question = @test.questions.all[next_question]
        test_session(@test)[:current_question] = next_question                                                           
      else       
        # test finished           
        save_test_result @test        
        clear_test_session(@test)        
        redirect_to result_user_subject_test_path(@teacher, @subject, @test)                
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
      
    send_file file_path, :type => "application/excel"
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
    if test_session(test) && test_session(test)[:psw] == test.crypted_password
      yield
    else
      redirect_to :action => "before_pass" 
    end
  end
  
  def clear_test_session test 
    session["test_#{test.id}"] = nil
  end
  
  def test_session test
    session["test_#{test.id}"]
  end

  def create_test_session test, student, student_class
    session["test_#{test.id}"] = { 
      :psw => test.crypted_password, 
      :student_class => student_class,
      :current_question => nil,
      :answered_questions => []
    }       
    
    # clear all user<->test db data
    UserAnswer.delete_all(["test_id = ? and user_id = ?", test.id, student.id])
    TestResult.delete_all(["test_id = ? and user_id = ?", test.id, student.id])    
  end
  
  USER_ANSWER_COLUMNS = [:user_id, :test_id, :question_id, :answer_id, :correct, :created_at, :updated_at]
  UPDATE_USER_ANSWER_COLUMNS = [:answer_id, :correct, :updated_at]  
  def save_answer test, question_number, answer_id
    return if !question_number || !answer_id
    
    question = test.questions.all[question_number]
    answer = question.answers.find_by_id(answer_id)
    
    return if !answer
    
    UserAnswer.import(USER_ANSWER_COLUMNS, 
      [[current_user.id, test.id, question.id, answer.id, answer.correct, Time.now, Time.now]], 
      :validate => false, :timestamps => false, :on_duplicate_key_update => UPDATE_USER_ANSWER_COLUMNS)
    
    test_session(test)[:answered_questions] << question_number
  end                                                             
                               
  TEST_RESULT_COLUMNS = [:user_id, :test_id, :student_class, :correct_count, :incorrect_count, :created_at, :updated_at]
  UPDATE_TEST_RESULT_COLUMNS = [:student_class, :correct_count, :incorrect_count, :updated_at]
  def save_test_result test
    correct_count = TestResult.get_correct_count(current_user, test)
    incorrect_count = TestResult.get_incorrect_count(current_user, test)

    TestResult.import(TEST_RESULT_COLUMNS, 
      [[current_user.id, @test.id, test_session(test)[:student_class], correct_count, incorrect_count, Time.now, Time.now]], 
      :validate => false, :timestamps => false, :on_duplicate_key_update => UPDATE_TEST_RESULT_COLUMNS)        
  end                                                                                                      
  
  def get_random_next_question_number test
    answered_questions = test_session(test)[:answered_questions]
    all_questions = []
    test.questions.length.times { |i| all_questions << i }
    
    possible_questions = all_questions - answered_questions
    return nil if possible_questions.empty?
    
    possible_questions[rand(possible_questions.length)]
  end
end
