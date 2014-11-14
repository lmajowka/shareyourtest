class RatingsController < ApplicationController
  def create
    @rating = Rating.find_or_create_by(exam_id: params[:exam_id], user_id: current_user.id)
    @exam = @rating.exam
    @rating.update_attributes(score: params[:score])
    render text: "ok"
  end
end
