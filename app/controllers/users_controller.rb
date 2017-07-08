class UsersController < ApplicationController

  before_action :logged_in_user, except: [:new, :create]


  def show

  end

  def dashboard

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
    @user = current_user

  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'Info Updated'
      redirect_to dashboard_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :title,
                                 :company_name, :company_address, :city, :state, :zip_code, :role, :dm_evaluating, :sp_product_service,
                                 :phone_number, :ar_first_name, :ar_last_name, :ar_phone_number, :ar_email, :ar_account_number, :wildcard
    )
  end

end
