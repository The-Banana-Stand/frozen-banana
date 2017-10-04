class Question < ApplicationRecord

  belongs_to :user
  belongs_to :paid_inbox

  validates_presence_of :question

  after_create :send_slack_notification

  monetize :price_cents, :platform_fee_cents

  private

  def send_slack_notification
    SlackWrapper.new_question_notification(self)
  end
end
