class InvitesController < ApplicationController

  def new
    @invite = Invite.new
  end

  def create
    @invite = current_user.invites.build(invite_params)

    if @invite.save
      flash[:success] = 'Invite Sent'
      redirect_to new_invite_path
    else
      render 'new'
    end
  end


  private

  def invite_params
    params.require(:invite).permit(:email, :first_name, :last_name, :title,
                                 :company_name, :company_address, :city, :state, :zip_code, :phone_number, :attachment
    )
  end
end
