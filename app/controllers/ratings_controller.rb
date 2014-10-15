class RatingsController < ApplicationController
  def update
    @rating = Rating.find(params[:id])
    return unless belongs_to_me? @rating.user_id
    @exam = @rating.exam
    @rating.update_attributes(score: params[:score])
    render text: "ok"
  end
end
