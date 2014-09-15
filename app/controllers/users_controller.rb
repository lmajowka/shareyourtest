class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end


  def show

  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
