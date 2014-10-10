class AnswersController < ApplicationController

  layout 'answers'

  def show
  	@test = Exam.find_by_permalink params[:permalink]
  end

end