class MeetingsController < ApplicationController

  before_action :authenticate_user!

  def new
    @decision_maker = User.find(params[:id])
    # @desired_block = GeneralAvailability.includes(:user).find(params[:id])
    @meeting = Meeting.new(dm_id: params[:id])
  end


  def create
    @meeting = Meeting.new(meeting_params)

    #currently no way for meeting save to error, leaving in for future use
    if @meeting.save
      current_user.process_payment_info(params[:stripeToken])
      redirect_to confirm_meeting_path(@meeting.id)
    else
      @decision_maker = User.find(params[:meeting][:dm_id])
      # @desired_block = GeneralAvailability.includes(:user).find(params[:meeting][:desired_block_id])
      render :new
    end

  #   not using stripe
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render :new
  end


  def confirm_meeting
    @meeting = Meeting.find(params[:id])
  end

  private

  def meeting_params
    params.require(:meeting).permit(:dm_id, :sp_id, :price_cents, :sp_requested_comments,
                                    :topic, :sp_lead_qualification, :platform_fee_cents,
                                    :desired_start_time, :desired_end_time, :desired_day)
  end


end
