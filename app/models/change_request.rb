class ChangeRequest < ApplicationRecord
  has_paper_trail
  belongs_to :user
  belongs_to :meeting
  auto_strip_attributes :request

  validates :request, presence: true

  after_create :send_slack_notification


  private

  def send_slack_notification
    if Rails.env.production?
      meeting = self.meeting
      notification = {
          text: 'New Change Request',
          username: "Awesom-O",
          icon_emoji: ":loudspeaker:",
          fields: [
              {
                  title: 'New Change Request From:',
                  value: "#{self.user.full_name} (#{self.user_id}) - #{self.user.email} - #{self.user.phone_number} - #{self.user.company_name}"
              },
              {
                  title: 'For Meeting:',
                  value: "ID: #{self.meeting_id} | Confirmation#: #{meeting.confirmation_number} | Meeting Status: #{meeting.status}"
              },
              {
                  title: 'Request:',
                  value: "#{self.request}"
              },
              {
                  title: 'Decision Maker',
                  value: "#{meeting.dm.full_name} (#{meeting.dm_id}) - #{meeting.dm.email} - #{meeting.dm.phone_number} - #{meeting.dm.company_name}"
              },
              {
                  title: 'Decision Maker Address',
                  value: "#{meeting.dm.full_address}"
              },
              {
                  title: 'Salesperson',
                  value: "#{meeting.sp.full_name} (#{meeting.sp_id}) - #{meeting.sp.email} - #{meeting.sp.phone_number} - #{meeting.sp.company_name}"
              },
              {
                  title: 'Desired Time',
                  value: "#{meeting.desired_block.display_day}, between #{meeting.desired_block.show_start_time} to #{meeting.desired_block.show_end_time}"
              },
              {
                  title: 'Price/Hr',
                  value: "#{meeting.price.format} (total: #{meeting.total_price.format}"
              },
              {
                  title: 'Comments from Salesperson',
                  value: "#{meeting.sp_requested_comments}"
              }

          ]
      }
      SLACK.ping notification
    end
  end


end
