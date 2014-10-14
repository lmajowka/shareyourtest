class UsersController < ApplicationController

  def create

    user = User.find_by(email: params[:user][:email].downcase)
    if user && user.authenticate(params[:user][:password])
      sign_in user
      flash[:success] = "Welcome to Share your Test!"
      redirect_to user
    else
      @user = User.new(user_params)
      if @user.save
        sign_in @user
        redirect_to @user
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

end
