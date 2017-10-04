class CardsController < ApplicationController

  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.process_payment_info(params[:stripeToken])
    flash[:success] = 'Payment Info Updated'
    redirect_to edit_card_path
  end

  def update_card
    @form_id = params[:form_id]
    respond_to do |format|
      format.js
    end
  end


end
