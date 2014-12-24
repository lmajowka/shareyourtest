class ExamCategoriesController < ApplicationController
  def show
    @exam_category = ExamCategory.find_by_permalink params[:id]
    @tests = Exam.where(exam_category_id: @exam_category.id).limit(3)
    @sample_question = @tests.first.questions.first if @tests.size > 0
    @embeddable = Embeddable.new
    @facebook_pages = facebook_pages
  end

  def new
    return render text: "404" unless current_user and current_user.admin?
    @exam = ExamCategory.new
  end

  def create
    if current_user.admin?
      exam_category = ExamCategory.new(exam_category_params)
      if exam_category.save
        redirect_to exam_category
      else
        render 'new'
      end
    end
  end

  def update
    if current_user.admin?
      exam_category = ExamCategory.find_by_permalink(params[:id])
      exam_category.update(exam_category_params)
      if exam_category.save
        redirect_to exam_category
      else
        render '404'
      end
    end
  end

  private

  def exam_category_params
    params.require(:exam_category).permit(:name,:description,:info,:calendar)
  end

  def facebook_pages
    {
      toefl: 'https://www.facebook.com/toeflsampletests',
      anbima: 'https://www.facebook.com/cpa10gratis',
      ielts: 'https://www.facebook.com/ieltsdailyquestions'
    }
  end

end
