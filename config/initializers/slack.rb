require 'slack-notifier'

SLACK = Slack::Notifier.new ENV['SLACK'] do
  defaults channel: '#notifications',
           username: 'notifier'
end