class CardsController < ApplicationController

  before_action :authenticate_user!

  def update_card
    @form_id = params[:form_id]
    respond_to do |format|
      format.js
    end
  end


end
