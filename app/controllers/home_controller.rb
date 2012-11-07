class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to current_user
    else
      redirect_to signin_path
    end
  end
end
