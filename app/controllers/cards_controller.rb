class CardsController < ApplicationController

  before_action :authenticate_user!

  def update_card

    respond_to do |format|
      format.js {

      }
    end
  end


end
