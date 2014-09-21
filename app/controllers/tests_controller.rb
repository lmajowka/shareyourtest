class TestsController < ApplicationController

  def index
    @tests = Exam.all
  end

  def create
    @test = current_user.exams.new(test_params)
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
  end

  private

  def test_params
    params.require(:exam).permit(:title,:description)
  end

end
