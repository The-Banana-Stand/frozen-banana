class MeetingsController < ApplicationController

  before_action :logged_in_user

  def new
    @user = current_user
    @desired_block = GeneralAvailability.find(params[:id])
    @decision_maker = @desired_block.user
  end


  def create
    @desired_block = GeneralAvailability.find(params[:desired_block_id])
    @decision_maker = @desired_block.user

    current_user.create_stripe_customer(params[:stripeToken])

    meeting = Meeting.create!(dm_id: @decision_maker.id, sp_id: current_user.id, price_cents: @decision_maker.price_cents,
                    time_start: @desired_block.start_time, time_end: @desired_block.end_time)

    redirect_to confirmation_path(meeting.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_meeting_path
  end


  def confirmation
    @meeting = Meeting.find(params[:id])
  end


end
