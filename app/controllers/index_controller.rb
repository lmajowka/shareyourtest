class IndexController < ApplicationController

  def index
    if signed_in?
      redirect_to current_user
    end
    @user = User.new
    @test1 = Exam.first
    @test2 = Exam.last
    @test3 = Exam.first
  end

end
