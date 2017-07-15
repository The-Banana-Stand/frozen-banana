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
      flash[:danger] = 'Nice Try'
      redirect_to main_app.root_path
    end
  end

  

  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  config.audit_with :paper_trail, 'Meeting', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  PAPER_TRAIL_AUDIT_MODEL = ['User', 'Meeting']
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
    # show_in_app
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
