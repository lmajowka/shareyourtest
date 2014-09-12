class IndexController < ApplicationController

  def index
    @user = User.new
  end

end
