class IndexController < ApplicationController

  def index
    if signed_in?
      redirect_to :exams
    end
    @user = User.new
    @test1 = Exam.first
    @test2 = Exam.last
    @test3 = Exam.first
  end

end
