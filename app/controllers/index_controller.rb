class IndexController < ApplicationController

  def index
    if signed_in?
      redirect_to current_user
    end
    @user = User.new
    @tests = Exam.published.limit 3
    @homepage = true
    @number_of_tests = Exam.published.count
  end

end
