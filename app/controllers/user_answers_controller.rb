class UserAnswersController < ApplicationController

  def create
  	@user_answer = UserAnswer.find_or_create_by(user_answers_params)
  	render json: @user_answer.to_json
  end

  def update
  	@user_answer = UserAnswer.find(params[:id])
  	return unless belongs_to_me?(@user_answer.user_id)
  	@user_answer.update(user_answers_params)
  	@user_answer.save!
  	render json: @user_answer.to_json
  end

  private

  def user_answers_params
  	params.permit(:user_id,:purchase_id,:question_id,:answer_id,:id)
  end	

end
