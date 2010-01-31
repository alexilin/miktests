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
    @test = @subject.tests.find(params[:id])
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
