require 'slack-notifier'
channel = Rails.env.production? ? '#notifications' : '#dev_notifications'
SLACK = Slack::Notifier.new ENV['SLACK'] do
  defaults channel: channel,
           username: 'notifier'
end