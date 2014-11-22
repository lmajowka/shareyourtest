
class AnswersController < ApplicationController

  layout 'answers'

  def show
  	@test = Exam.find_by_permalink params[:permalink]
    get_purchase	
  	@user_answers = UserAnswer.ordered_answers_for @purchase
    @rating = Rating.where(exam_id: @test.id, user_id: current_user.id).any?
    @picture_urls = Hash.new
    @test.questions.map{|q| q.comments}.first.each do |c|
      pic = c.user.picture.url
      additional = (pic == "nopictureuser.jpg") ? "/assets/" : ""
      @picture_urls[c.user.id] = additional + pic
    end
    @picture_urls = @picture_urls.to_json
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