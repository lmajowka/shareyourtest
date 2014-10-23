class IndexController < ApplicationController

  def index
    if signed_in?
      redirect_to current_user
    end
    @user = User.new
    @tests = Exam.published.limit 3
    @homepage = true
  end

end
