class ExamCategoriesController < ApplicationController
  def show
    @exam_category = ExamCategory.find_by_permalink params[:id]
    @tests = Exam.where(exam_category_id: @exam_category.id)
  end
end
