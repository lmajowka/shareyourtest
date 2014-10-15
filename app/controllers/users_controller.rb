class UsersController < ApplicationController

  def create
    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      sign_in_and_redirect(user)      
    else
      @user = User.new(user_params)
      if @user.save
        sign_in_and_redirect(@user)
      else
        render 'new'
      end
    end
  end

  def show
    @exams = current_user.purchases.map(&:exam).uniq
  end

  def new
    @user = User.new()
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end

  def sign_in_and_redirect(user)
    sign_in user
    if cookies["last-test-page"]
        redirect_to cookies["last-test-page"]
      else   
        redirect_to user
      end
  end

end
