class ApplicationMailer < ActionMailer::Base
  default from: 'donotreply.frozenbanana@gmail.com' #TODO acquire new email
  layout 'mailer'
end
