
class AnswersController < ApplicationController

  layout 'answers'

  def show
  	@test = Exam.find_by_permalink params[:permalink]
    get_purchase
    return not_found if @purchase.nil?
  	@user_answers = UserAnswer.ordered_answers_for @purchase
    @rating = Rating.where(exam_id: @test.id, user_id: current_user.id).any?

    @picture_urls = Hash.new
    @commenters_name = Hash.new

    comments.each do |c|
      pic = c.user.picture.url
      additional = (pic == "nopictureuser.jpg") ? "/assets/" : ""
      @picture_urls[c.user.id] = additional + pic
      @commenters_name[c.user.id] = c.user.name
    end
    @picture_urls = @picture_urls.to_json
    @commenters_name = @commenters_name.to_json
  end

  private

  def comments
    @test.questions.reject{|q| q.comments.size == 0}.map{|q| q.comments}.flatten
  end

  def get_purchase
  	if params[:id]
  	  @purchase = Purchase.find_by_id params[:id]
      return if @purchase.nil?
  	  @purchase = nil unless belongs_to_me?(@purchase.user_id)
  	else
  	  @purchase = current_user.get_ready_purchase @test
  	  if not @purchase
  	    @purchase = current_user.purchase_exam @test
  	  end	
  	end	
  end

end