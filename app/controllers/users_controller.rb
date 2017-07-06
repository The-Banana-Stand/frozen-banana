class UsersController < ApplicationController


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
      log_in @user
      remember @user
      flash[:success] = 'Welcome to B2B Direct!'
      redirect_to '/'
    else
      render :new
    end
  end

  def edit

  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :title,
                                 :company_name, :company_address, :city, :state, :zip_code, :role, :dm_evaluating, :sp_product_service,
                                 :phone_number, :ar_first_name, :ar_last_name, :ar_phone_number, :ar_email, :ar_account_number
    )
  end

end
