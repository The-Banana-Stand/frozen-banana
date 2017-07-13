class MeetingsController < ApplicationController

  before_action :logged_in_user

  def new
    @user = current_user
    @desired_block = GeneralAvailability.find(params[:id])
    @decision_maker = @desired_block.user
  end


end
