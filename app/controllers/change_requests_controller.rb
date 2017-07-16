class ChangeRequestsController < ApplicationController

  def new
    @meeting = Meeting.find(params[:id])
    @change_request = @meeting.change_requests.build(user_id: current_user.id)
  end

  def create
    @change_request = ChangeRequest.new(change_request_params)

    if @change_request.save
      @change_request.meeting.update_attribute(:status, 'change_pending')
      flash[:info] = 'Change Requested'
      redirect_to dashboard_path
    else
      @meeting = Meeting.find(params[:change_request][:meeting_id])
      render 'new'
    end
  end

  private

  def change_request_params
    params.require(:change_request).permit(:request, :meeting_id, :user_id)
  end

end
