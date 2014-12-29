class QuestionsController < ApplicationController

  include Commentable

  def create
    @question = Question.create!(question_params)
    create_answers if @question
    cookies["new-question"] = "true"
    render json: @question.to_json
  end

  def index
    @questions = Question.includes(:answers).where(exam_id: params[:exam_id]).order(:position)
    render json: @questions.to_json(include: :answers)
  end

  def destroy
    render json:[].to_json unless my_exam?
    if @question = Question.find_by(id: params[:id], exam_id: params[:exam_id])
      @question.remove
    end
    render json: @question.to_json
  end

  def update
    return unless my_exam?
    @question = Question.find_by(id: params[:id], exam_id: params[:exam_id])
    @question.update question_params
    if @question.save!
      @question.remove_answers
      create_answers
    end  
    render json: @question.to_json
  end  

  def create_answers
    answers = params[:answers]
    answers.each do |answer|
      @question.answers.create!(content:answer[:content])
    end
  end  

  private

  def my_exam?
    exam = Exam.find(params[:exam_id])
    belongs_to_me?(exam.user_id)
  end

  def question_params
    return false unless my_exam?
    return false if params[:answers].size < 2
    params.require(:question).permit(:content,:answer).merge(exam_id: params[:exam_id])
  end

end
