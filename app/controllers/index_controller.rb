class IndexController < ApplicationController

  def index
    if signed_in?
      redirect_to :tests
    end
    @user = User.new
  end

end
