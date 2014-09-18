class TestsController < ApplicationController

  def index
    @tests = Test.all
  end

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to @test
    else
      render 'new'
    end
  end

  def new
    if !signed_in?
      redirect_to :signup
    end
    @test = Test.new()
  end

  def show
    @test = Test.find params[:id]
  end

  private

  def test_params
    params.require(:test).permit(:title,:description)
  end

end
