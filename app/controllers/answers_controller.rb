
class AnswersController < ApplicationController

  layout 'answers'

  def show
  	@test = Exam.find_by_permalink params[:permalink]
    get_purchase	
  	@user_answers = UserAnswer.ordered_answers_for @purchase
    @rating = Rating.where(exam_id: @test.id, user_id: current_user.id).any?
  end

  private

  def get_purchase
  	if params[:id]
  	  @purchase = Purchase.find params[:id]
  	  @purchase = nil unless belongs_to_me?(@purchase.user_id)
  	else
  	  @purchase = current_user.get_ready_purchase @test
  	  if not @purchase
  	    @purchase = current_user.purchase_exam @test
  	  end	
  	end	
  end

end