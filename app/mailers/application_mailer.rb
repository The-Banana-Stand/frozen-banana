class ApplicationMailer < ActionMailer::Base
  default from: 'admin@meetingslice.com' #TODO acquire new email
  layout 'mailer'
end
