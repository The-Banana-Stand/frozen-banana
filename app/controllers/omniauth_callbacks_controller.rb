class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_action :authenticate_user!

  def linkedin
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Linkedin") if is_navigational_format?
    else

      render 'devise/registrations/new'
    end
  end

  def failure
    flash[:danger] = 'Linkedin sign in failed.'
    redirect_to root_path
  end
end