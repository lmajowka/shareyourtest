class QuestionsController < ApplicationController

  def create
    debugger
    @question = Question.create!(question_params)
    render json: @question.to_json
  end

  private

  def question_params
    params.require(:question).permit(:content,:answer)
  end

end
