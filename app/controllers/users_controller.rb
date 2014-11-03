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
    @user = User.find_by_permalink params[:id]
    @my_profile = @user == current_user
    @exams = current_user.purchases.map(&:exam).uniq if @my_profile
  end

  def new
    @user = User.new()
  end

  def update
    current_user.update(update_params)
    current_user.save
    redirect_to current_user
  end

  private

  def update_params
    params[:picture] = params[:user][:picture] if params[:user][:picture]
    params[:bio] = params[:user][:bio] if params[:user][:bio]
    params.permit(:picture, :bio)
  end

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
