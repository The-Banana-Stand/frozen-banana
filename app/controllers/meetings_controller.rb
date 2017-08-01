class MeetingsController < ApplicationController

  before_action :authenticate_user!

  def new
    @desired_block = GeneralAvailability.includes(:user).find(params[:id])
    @meeting = @desired_block.meetings.build(dm_id: @desired_block.user_id)
  end


  def create
    @meeting = Meeting.new(meeting_params)

    if @meeting.save
    current_user.process_payment_info(params[:stripeToken])
    redirect_to confirm_meeting_path(@meeting.id)
    else
      @desired_block = GeneralAvailability.includes(:user).find(@meeting.general_availability_id)
      render :new
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :new
  end


  def confirm_meeting
    @meeting = Meeting.find(params[:id])
  end

  private

  def meeting_params
    params.require(:meeting).permit(:dm_id, :sp_id, :price_cents, :general_availability_id, :sp_requested_comments,
                                    :topic, :sp_lead_qualification, :platform_fee_cents)
  end


end
