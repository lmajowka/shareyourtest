class TestsController < ApplicationController

  def index
    @tests = Exam.published
  end

  def create
    @test = current_user.exams.new(test_params)
    @test.status = "draft"
    if @test.save
      redirect_to @test
    else
      render 'new'
    end
  end

  def new
    if !signed_in?
      redirect_to :signup
    end
    @test = Exam.new()
  end

  def show
    @test = Exam.find params[:id]
    @question = Question.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @test }
      format.json { render :json => @test }
    end
  end

  private

  def test_params
    params.require(:exam).permit(:title,:description)
  end

end
