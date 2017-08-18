class UsersController < ApplicationController

  skip_before_action :authenticate_user!, only: [:verify, :resend_email, :verify_help]
  skip_before_action :account_setup_redirect, only: :account_setup


  def verify
    @user = User.find(params[:id])
  end

  def resend_email
    @user = User.find(params[:id])
    @user.resend_confirmation_instructions
    flash[:success] = 'Instructions Resent'
    redirect_to user_verify_path(@user.id)
  end

  def verify_help
    @user = User.find(params[:user][:id])
    @user.send_confirmation_help_request(params[:user][:phone_number])
    flash[:info] = 'We will contact you shortly.'
    redirect_to user_verify_path(@user.id)
  end

  def dashboard
    @user = current_user
    @meetings = @user.all_meetings.includes(:dm, :sp).order(:sort_priority, date: :asc, time_start: :asc, id: :desc)
  end

  def schedule_time
    @user = current_user

    # If no search params, default to empty search
    # if params[:q] && params[:q].reject { |k, v| v.blank? }.present?
      @query = User.includes(:active_blocks).confirmed.is_decision_maker.ransack(params[:q])
      @decision_makers = @query.result
    # else
    #   @query = User.ransack
    #   @decision_makers = []
    # end

  end

  def account_setup
    @user = current_user
    if @user.role
      flash[:warning] = 'Your account is already set up.'
      redirect_to :dashboard
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(user_params)
        format.html {
          flash[:success] = 'Information Saved'
          if URI(request.referer).path == edit_profile_path
            redirect_to edit_profile_path
          else
            redirect_to dashboard_path
          end
        }

        format.js {flash.now[:success] = 'Information Saved'}

      else
        format.html {render :edit}
        format.js
      end

    end




  end


  private

  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :title,
                                 :company_name, :company_address, :city, :state, :zip_code, :role, :dm_evaluating, :avatar,
                                 :sp_product_service, :phone_number, :ar_first_name, :ar_last_name, :ar_phone_number,
                                 :ar_email, :ar_account_number, :dm_min_bottom_line_impact, :sp_small_revenue,
                                 :sp_medium_revenue, :sp_large_revenue, :sp_small_revenue_examples,
                                 :sp_medium_revenue_examples, :sp_large_revenue_examples, :sp_sales_cycle,
                                 :sp_close_percentage, :sp_organization_close_percentage,
                                 general_availabilities_attributes: [:id, :day, :start_time, :end_time]
    )
  end

end
