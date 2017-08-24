class ApplicationMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  default from: "\"MeetingSlice\" <do_not_reply@meetingslice.com>"
  layout 'mailer'
end
