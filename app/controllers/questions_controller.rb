class QuestionsController < ApplicationController

  def create
    @question = Question.create!(questions_params)
    render json: @question.to_json
  end

  private

  def questions_params
    params.require(:question).permit(:content)
  end

end
