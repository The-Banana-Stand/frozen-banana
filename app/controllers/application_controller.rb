class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_paper_trail_whodunnit, :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation, :first_name, :last_name, :title,
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
end
