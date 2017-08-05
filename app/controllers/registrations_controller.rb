class RegistrationsController < Devise::RegistrationsController

  protected

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def after_inactive_sign_up_path_for(resource)
    user_verify_path(resource.id)
  end
end