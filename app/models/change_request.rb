class ChangeRequest < ApplicationRecord
  has_paper_trail
  belongs_to :user
  belongs_to :meeting
  auto_strip_attributes :request

  validates :request, presence: true

  after_create :send_slack_notification


  private

  def send_slack_notification
    SlackWrapper.new_change_request_notification(self)
  end


end
