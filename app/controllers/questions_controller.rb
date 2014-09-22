class QuestionsController < ApplicationController

  def create
    @question = Question.create!(question_params)
    answers = params[:answers]
    answers.each do |answer|
      @question.answers.create!(content:answer)
    end
    render json: @question.to_json
  end

  def index
    @questions = Question.where(exam_id: params[:exam_id])
    render json: @questions.to_json
  end

  def destroy
    if my_exam
      @question = Question.where(id: params[:id], exam_id: params[:exam_id])
      if @question.size > 0
        Answer.where(question_id:@question.first.id).destroy_all
        @question.first.delete
      end
    end
    render json: @question.to_json
  end


  private

  def my_exam
    exam = Exam.find(params[:exam_id])

    if !belongs_to_me?(exam.user_id)
      return false
    end

    true
  end

  def question_params
    return false unless my_exam
    params.require(:question).permit(:content,:answer).merge(exam_id: params[:exam_id])
  end

end
