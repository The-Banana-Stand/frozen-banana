class ApplicationMailer < ActionMailer::Base
  default from: 'do_not_reply@meetingslice.com' #TODO acquire new email
  layout 'mailer'
end
