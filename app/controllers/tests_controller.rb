require 'ar-extensions'
require 'ar-extensions/adapters/mysql'
require 'ar-extensions/import/mysql'

class TestsController < ApplicationController

  before_filter :load_teacher, :load_subject

  # GET /tests
  # GET /tests.xml
  def index
    @tests = @subject.tests
  end

  # GET /tests/1
  # GET /tests/1.xml
  def show
    @test = @subject.tests.find_by_id(params[:id])        
  end                                           
      
  USER_ANSWER_COLUMNS = [:user_id, :test_id, :question_id, :answer_id, :correct, :created_at, :updated_at]
  UPDATE_USER_ANSWER_COLUMNS = [:answer_id, :correct, :updated_at]
  
  TEST_RESULT_COLUMNS = [:user_id, :test_id, :correct_count, :incorrect_count, :created_at, :updated_at]
  UPDATE_TEST_RESULT_COLUMNS = [:correct_count, :incorrect_count, :updated_at]
  
  def pass
    @test = @subject.tests.find_by_id(params[:id])        
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
          [[current_user.id, @test.id, correct_count, incorrect_count, Time.now, Time.now]], 
          :validate => false, :timestamps => false,
          :on_duplicate_key_update => UPDATE_TEST_RESULT_COLUMNS)
          
        redirect_to result_user_subject_test_path(@teacher, @subject, @test)
      else
        redirect_to pass_user_subject_test_path(@teacher, @subject, @test, :q => @qnumber)
      end
    end                
  end                    
  
  def result                                              
    @test = @subject.tests.find_by_id(params[:id])        
    @result = TestResult.find_by_user_id_and_test_id(current_user.id, @test.id)
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
    @test = @subject.tests.find(params[:id])
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
    @test = @subject.tests.find(params[:id])
    if @test.update_attributes(params[:test])
      redirect_to user_subject_tests_path
    else
      render :action => "edit"
    end
  end

  # DELETE /tests/1
  # DELETE /tests/1.xml
  def destroy
    @test = Test.find(params[:id])
    @test.destroy

    respond_to do |format|
      format.html { redirect_to(tests_url) }
      format.xml  { head :ok }
    end
  end
end
