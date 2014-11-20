class ExamCategoriesController < ApplicationController
  def show
    @exam_category = ExamCategory.find_by_permalink params[:id]
    @tests = Exam.where(exam_category_id: @exam_category.id)
    @sample_question = @tests.first.questions.first
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
    params.require(:exam_category).permit(:name,:info)
  end

end
