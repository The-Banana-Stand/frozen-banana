require Rails.root.join('lib', 'rails_admin', 'payment_capture.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::PaymentCapture)

require Rails.root.join('lib', 'rails_admin', 'impersonate.rb')
RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::Impersonate)


RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.parent_controller = "::ApplicationController"

  config.current_user_method(&:current_user)
  config.authenticate_with do
    unless current_user.try(:admin)
      flash[:danger] = 'You are not supposed to go there.'
      redirect_to main_app.root_path
    end
  end

  

  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  config.audit_with :paper_trail, 'Meeting', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  config.audit_with :paper_trail, 'Invite', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  config.audit_with :paper_trail, 'GeneralAvailability', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  config.audit_with :paper_trail, 'ChangeRequest', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  config.audit_with :paper_trail, 'Feedback', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  PAPER_TRAIL_AUDIT_MODEL = ['User', 'Meeting', 'Invite', 'GeneralAvailability', 'ChangeRequest', 'Feedback']
  config.actions do
    history_index do
      only PAPER_TRAIL_AUDIT_MODEL
    end
    history_show do
      only PAPER_TRAIL_AUDIT_MODEL
    end
  end

  config.model 'User' do
    object_label_method do
      :full_name
    end

    show do
      field :admin_comments
      field :ar_comments
      field :filter_comments
      field :validation_comments
      field :plat_validation_status
      field :first_name
      field :last_name
      field :company_name
      field :title
      field :email
      field :phone_number
      field :company_address
      field :city
      field :state
      field :zip_code
      field :username
      field :sp_product_service
      field :dm_evaluating
      field :active
      field :role
      field :activated
      field :price_cents
      field :price_currency
      field :dm_min_bottom_line_impact
      field :sp_small_revenue
      field :sp_medium_revenue
      field :sp_large_revenue
      field :sp_small_revenue_examples
      field :sp_medium_revenue_examples
      field :sp_large_revenue_examples
      field :sp_sales_cycle
      field :sp_close_percentage
      field :sp_organization_close_percentage
      field :customer_token
      field :admin
      field :created_at
    end

    list do
      field :admin_comments
      field :ar_comments
      field :filter_comments
      field :validation_comments
      field :plat_validation_status
      field :first_name
      field :last_name
      field :company_name
      field :title
      field :email
      field :phone_number
      field :company_address
      field :city
      field :state
      field :zip_code
      field :username
      field :sp_product_service
      field :dm_evaluating
      field :active
      field :role
      field :activated
      field :price_cents
      field :price_currency
      field :dm_min_bottom_line_impact
      field :customer_token
      field :admin
      field :created_at
    end

    create do
      field :admin_comments
      field :ar_comments
      field :filter_comments
      field :validation_comments
      field :plat_validation_status
      field :first_name
      field :last_name
      field :company_name
      field :title
      field :email
      field :password
      field :password_confirmation
      field :phone_number
      field :company_address
      field :city
      field :state
      field :zip_code
      field :username
      field :sp_product_service
      field :dm_evaluating
      field :active
      field :role
      field :activated
      field :price_cents
      field :price_currency
      field :dm_min_bottom_line_impact
      field :sp_small_revenue
      field :sp_medium_revenue
      field :sp_large_revenue
      field :sp_small_revenue_examples
      field :sp_medium_revenue_examples
      field :sp_large_revenue_examples
      field :sp_sales_cycle
      field :sp_close_percentage
      field :sp_organization_close_percentage
      field :customer_token
      field :admin
      field :created_at
    end

    edit do
      field :admin_comments
      field :ar_comments
      field :filter_comments
      field :validation_comments
      field :plat_validation_status
      field :first_name
      field :last_name
      field :company_name
      field :title
      field :email
      field :phone_number
      field :company_address
      field :city
      field :state
      field :zip_code
      field :username
      field :sp_product_service
      field :dm_evaluating
      field :active
      field :role
      field :activated
      field :price_cents
      field :price_currency
      field :dm_min_bottom_line_impact
      field :sp_small_revenue
      field :sp_medium_revenue
      field :sp_large_revenue
      field :sp_small_revenue_examples
      field :sp_medium_revenue_examples
      field :sp_large_revenue_examples
      field :sp_sales_cycle
      field :sp_close_percentage
      field :sp_organization_close_percentage
      field :customer_token
      field :admin
      field :created_at
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    payment_capture
    impersonate
    # show_in_app
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
