class ChangeRequest < ApplicationRecord
  has_paper_trail
  belongs_to :user
  belongs_to :meeting
  auto_strip_attributes :request

  validates :request, presence: true

  after_create :send_slack_notification


  private

  def send_slack_notification
    notification = {
        text: 'hello hello',
        username: "Awesom-O",
        icon_emoji: ":loudspeaker:",
        fields: [
            {
                title: 'New Change Request From:',
                value: "#{self.user.full_name} (#{self.user_id})"
            },
            {
                title: 'For Meeting:',
                value: "#{self.meeting_id}"
            },
            {
                title: 'Request:',
                value: "#{self.request}"
            }
        ]
    }
    SLACK.ping notification
  end


end
