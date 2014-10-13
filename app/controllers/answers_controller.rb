
class AnswersController < ApplicationController

  layout 'answers'

  def show
  	@test = Exam.find_by_permalink params[:permalink]
  	@purchase = current_user.get_ready_purchase @test
  	if not @purchase
  	  @purchase = current_user.purchase_exam @test
  	end
  end

end