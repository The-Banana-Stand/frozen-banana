class CustomDeviseMailer < Devise::Mailer
  layout 'mailer'
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
  default from: 'do_not_reply@meetingslice.com'


  # def playground_email(user)
  #   @resource = user
  #   @token = 'faketoken'
  #   mail to: @resource.email, subject: 'Testing'
  # end

end