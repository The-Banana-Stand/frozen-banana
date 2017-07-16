class UsersController < ApplicationController

  skip_before_action :logged_in_user, only: [:new, :create]


  def show

  end

  def dashboard
    @user = current_user
    @meetings = @user.dm_meetings.includes(:dm, :sp) + @user.sp_meetings.includes(:dm, :sp, :desired_block)
    @meetings.sort! {|x, y| x.sort_priority <=> y.sort_priority}
  end

  def schedule_time
    @user = current_user

    # If no search params, default to empty search
    if params[:q] && params[:q].reject { |k, v| v.blank? }.present?
      @query = User.includes(:active_blocks).activated.is_decision_maker.ransack(params[:q])
      @decision_makers = @query.result
    else
      @query = User.ransack
      @decision_makers = []
    end

    session[:return_to] = schedule_time_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.account_setup
      if Rails.env == 'development' #TODO remove this once account setup process is complete
        @user.activate
        log_in @user
        redirect_to account_setup_path
      else
        flash[:info] = 'Please check your email to activate your account.'
        redirect_to root_url
      end
    else
      render :new
    end
  end

  def edit
    @user = current_user
    session[:return_to] = edit_profile_path
  end

  def account_setup
    @user = current_user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'Information Saved'
      redirect_to schedule_time_path
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :title,
                                 :company_name, :company_address, :city, :state, :zip_code, :role, :dm_evaluating,
                                 :sp_product_service, :phone_number, :ar_first_name, :ar_last_name, :ar_phone_number,
                                 :ar_email, :ar_account_number, :wildcard,
                                 general_availabilities_attributes: [:id, :day, :start_time, :end_time]
    )
  end

end
