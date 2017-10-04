class BidsController < ApplicationController

  before_action :authenticate_user!

  def create
    @bid = Bid.create(bid_params)
    respond_to do |format|
      format.js
    end
  end

  def update
    @bid = Bid.find(params[:id])

    if @bid.can_rebid
      @bid.can_rebid = false
      @bid.update_attributes!(bid_params)
      respond_to do |format|
        format.js {

        }
      end

    else
      raise 'Something Went Wrong'
    end
  end

  def destroy
    @bid = Bid.find(params[:id])

    @bid.update(status: :cancelled)

    respond_to do |format|
      format.js {

      }
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:user_id, :meeting_queue_id, :price, :price_cents)
  end
end
