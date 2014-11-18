class ReviewsController < ApplicationController

  def create
    return render {} unless user_already_answered
    return render {} if user_already_reviewed
    @review = Review.create!(review_params)
    render json: @review.to_json
  end

  private

  def review_params
    params.require(:review).permit(:content).merge(exam_id: params[:exam_id], user_id: current_user.id)
  end

  def user_already_reviewed
    Review.where(exam_id: params[:exam_id], user_id: current_user.id).any?
  end

  def user_already_answered
    current_user.purchases.answered_for(params[:exam_id]).any?
  end

end
