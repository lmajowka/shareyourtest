class TestsController < ApplicationController

  before_action :find_exam, only: [:update,:show]
  before_action :set_header, only: :show

  def index
    @tests = Exam.published
  end

  def create
    @test = current_user.created_exams.new(test_params)
    if @test.save
      current_user.purchase_exam @test
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
    if my_exam?
      @test.update(update_params)
      @test.save
      return redirect_to @test unless params[:status]
    end
    render json: @test.to_json
  end

  def show
    @question = Question.new
    @user = User.new
    @my_exam = my_exam?
    if current_user 
      @answered_purchases = current_user.purchases.answered_for @test.id
    else
      @answered_purchases = []
    end
    @average_rating = @test.average_rating 
    @number_of_ratings =  @test.pluralize_number_of_ratings
    @sample_question = @test.questions.first
    @ranking = Ranking.for @test
    respond_to do |format|
      format.html
      format.xml  { render :xml => @test }
      format.json { render :json => @test }
    end
  end

  def purchase
    render json: {status: "ok"}
  end  

  private

  def my_exam?
    belongs_to_me?(@test.user_id)
  end  

  def find_exam
    @test = Exam.find_by_permalink params[:id]
  end

  def update_params
    if params[:exam]
      params[:picture] = params[:exam][:picture]
      params[:title] = params[:exam][:title]
      params[:description] = params[:exam][:description]
    end
    params.permit(:status,:picture,:title,:description)
  end

  def test_params
    params.require(:exam).permit(:title,:description)
  end

  def set_header
    response.headers["Vary"]= "Accept"
  end
  
end
