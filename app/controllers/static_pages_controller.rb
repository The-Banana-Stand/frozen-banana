class StaticPagesController < ApplicationController

  skip_before_action :logged_in_user

  def home
    if logged_in?
      redirect_to dashboard_path
    end
  end


end
