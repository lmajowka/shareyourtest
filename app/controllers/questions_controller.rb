class QuestionsController < ApplicationController

  def create
    @question = Question.create!(question_params)
    render json: @question.to_json
  end

  private

  def question_params

    exam = Exam.find(params[:exam_id])

    if !belongs_to_me?(exam.user_id)
      return false
    end

    params.require(:question).permit(:content,:answer).merge(exam_id: params[:exam_id])
  end

end
