class IndexController < ApplicationController

  def index
    if signed_in?
      redirect_to :exams
    end
    @user = User.new
  end

end
