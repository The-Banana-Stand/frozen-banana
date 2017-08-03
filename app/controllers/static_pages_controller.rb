class StaticPagesController < ApplicationController

  skip_before_action :authenticate_user!

  def home
    @user = User.new
    if user_signed_in? && !params[:no_redirect]
      redirect_to dashboard_path
    end
  end

  def terms_of_service

  end

  def privacy_policy

  end

  def error
    raise 'Here, have an error.'
  end


end
