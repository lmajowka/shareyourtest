class IndexController < ApplicationController

  def index
    if signed_in?
      redirect_to current_user
    end
    @user = User.new
    @tests = []
    @tests << Exam.first
    @tests << Exam.last
    @tests << Exam.first
  end

end
