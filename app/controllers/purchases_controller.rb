class PurchasesController < ApplicationController

  def show
  	render text: "ok"
  end	

  def update
  	@purchase = Purchase.find params[:id]
  	return unless belongs_to_me?(@purchase.user_id)
  	@purchase.update(purchase_params)
  	render json: @purchase.to_json
  end

  def create
    @test = Exam.find_by_permalink params[:id]
    redirect_to @test.paypal_url(request.host,"/answers/#{params[:id]}")
  end

  private

  def purchase_params
  	params.permit(:id, :status)
  end

end
