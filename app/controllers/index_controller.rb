class IndexController < ApplicationController

  def index
    if signed_in?
      redirect_to current_user
    end
    @user = User.new
    @tests = Exam.located_for(@country).published.limit 3
    @homepage = true
    @number_of_tests = Exam.located_for(@country).published.count
  end

end
