class PurchasesController < ApplicationController

  protect_from_forgery except: [:hook]

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
    redirect_to @test.paypal_url(request.host,"/answers/#{params[:id]}",current_user)
  end

  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      invoice = Invoice.find params[:invoice].match(/[0-9]+/)[0]
      invoice.user.purchase_exam Exam.find(invoice.item_number)
    end
    render nothing: true
  end

  private

  def purchase_params
  	params.permit(:id, :status)
  end

end
