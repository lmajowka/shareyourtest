class TestsController < ApplicationController

  before_action :find_exam, only: [:update,:show]

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

  def update
    if belongs_to_me?(@test.user_id)
      @test.update(update_params)
    end
    render json: @test.to_json
  end

  def show
    @question = Question.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @test }
      format.json { render :json => @test }
    end
  end

  private

  def find_exam
    @test = Exam.find params[:id]
  end

  def update_params
    params.require(:exam).permit(:status,:picture)
  end

  def test_params
    params.require(:exam).permit(:title,:description)
  end

end
