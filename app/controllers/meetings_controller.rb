class MeetingsController < ApplicationController

  before_action :logged_in_user

  def new
    @user = current_user
    @desired_block = GeneralAvailability.includes(:user).find(params[:id])
    @meeting = @desired_block.meetings.build(dm_id: @desired_block.user_id)
  end


  def create
    @desired_block = GeneralAvailability.find(params[:meeting][:general_availability_id])
    @decision_maker = @desired_block.user

    current_user.create_stripe_customer(params[:meeting][:stripeToken])

    meeting = Meeting.create!(dm_id: @decision_maker.id, sp_id: current_user.id, price_cents: @decision_maker.price_cents,
                    general_availability_id: @desired_block.id, sp_requested_comments: params[:meeting][:sp_requested_comments])

    redirect_to confirmation_path(meeting.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_meeting_path
  end


  def confirmation
    @meeting = Meeting.find(params[:id])
  end


end
