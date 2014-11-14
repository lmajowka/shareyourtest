class TestsController < ApplicationController

  before_action :find_exam, only: [:update,:show]
  before_action :set_header, only: :show

  def index
    if params[:permalink]
      @category = ExamCategory.find_by_permalink params[:permalink]
      if @category
        @tests = @category.exams
        @category_name = @category.name
      else
        @tests = Exam.where("title like '%#{params[:permalink]}%'")
        @category_name = params[:permalink]
      end
    else
      @tests = Exam.published
      @category_name = "Tests"
    end
    @number_of_tests = @tests.size
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
    if my_exam? or current_user.admin?
      @test.update(update_params)
      @test.save
      return redirect_to @test unless params[:status]
    end
    render json: @test.to_json
  end

  def show
    @question = Question.new
    @user = User.new
    @review = Review.new
    @my_exam = my_exam?
    @chart_options = {
      title: "Max: 100%",
      colors: ['#b6c7F6']
    }
    if current_user 
      @answered_purchases = current_user.purchases.answered_for @test.id
    else
      @answered_purchases = []
      @average_performance  = @test.purchases.where('performance is not null').group(:performance).count
      @average = "Average"
    end
    @average_rating = @test.average_rating 
    @number_of_ratings =  @test.pluralize_number_of_ratings
    @sample_question = @test.questions.first
    @reviews = @test.reviews
    @show_review_form = show_review_form?
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
      params[:picture] = params[:exam][:picture] if params[:exam][:picture]
      params[:title] = params[:exam][:title] if params[:exam][:title]
      params[:description] = params[:exam][:description] if params[:exam][:description]
    end
    params.permit(:status,:picture,:title,:description,:exam_category_id)
  end

  def test_params
    params.require(:exam).permit(:title,:description)
  end

  def set_header
    response.headers["Vary"]= "Accept"
  end

  def show_review_form?
    return false unless current_user
    Purchase.where(user_id: current_user.id, exam_id: @test.id).any? and Review.where(exam_id: @test.id, user_id: current_user.id).empty?
  end
  
end
