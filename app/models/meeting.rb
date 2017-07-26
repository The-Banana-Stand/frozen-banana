class Meeting < ApplicationRecord
  has_paper_trail
  belongs_to :dm, class_name: 'User'
  belongs_to :sp, class_name: 'User'
  belongs_to :general_availability
  belongs_to :desired_block, class_name: 'GeneralAvailability', foreign_key: 'general_availability_id'
  has_one :feedback
  has_one :stripe_transaction
  has_many :change_requests, dependent: :destroy

  auto_strip_attributes :sp_requested_comments, :address, :instructions, :topic, :sp_lead_qualification

  attr_accessor :role, :second_party

  monetize :price_cents

  # validates :topic, :sp_lead_qualification, presence: true, length: 0..255

  before_save :set_sort_priority
  before_create :set_confirmation_number
  after_create :send_slack_notification


  def status_enum
    %w(requested scheduled completed change_pending cancelled test)
  end

  def payment_status_enum
    %w(pending captured refunded error)
  end

  def dm_calendar_status_enum
    %w(uncontacted contacted open_response invite_pending invite_accepted )
  end

  def sp_calendar_status_enum
    %w()
  end

  def set_sort_priority
    self.sort_priority = {
        'scheduled' => 1,
        'change_pending' => 2,
        'requested' => 3,
        'completed' => 4,
        'cancelled' => 5,
        'test' => 6

    }[self.status] || 99
  end

  def show_start_time
    time_start ? time_start.strftime('%l:%M%p') : 'Pending'
  end

  def show_end_time
    time_end ? time_end.strftime('%l:%M%p') : 'Pending'
  end

  def show_date
    self.date&.strftime('%m/%d/%Y') || 'Pending'
  end

  def set_display_attributes(id)
    self.role = display_role(id)
    self.second_party = meeting_with(id)
  end

  def display_role(id)
    if id == dm_id
      'Decision Maker'
    else
      'Sales Person'
    end
  end

  def meeting_with(id)
    if id == dm_id
      self.sp
    else
      self.dm
    end
  end

  def row_shade
    {
        'scheduled' => 'custom-success'
    }[status]
  end

  def capture_payment
    puts 'HELLO FROM CAPTURE PAYMENT!'
    return if self.payment_status == 'succeeded'
    customer = self.sp.stripe_customer

    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => price_cents,
        :description => "Charge for Meeting #{self.confirmation_number}",
        :currency    => 'usd'
    )


    self.update_attribute(:payment_status, charge.status)

    transaction = self.build_stripe_transaction({
                                                    amount: charge.amount,
                                                    dm_cut: self.dm.price_cents,
                                                    platform_cut: self.dm.platform_cut_price.fractional,
                                                    amount_refunded: charge.amount_refunded,
                                                    stripe_id: charge.id,
                                                    description: charge.description,
                                                    failure_code: charge.failure_code,
                                                    failure_message: charge.failure_message,
                                                    paid: charge.paid,
                                                    refunded: charge.refunded,
                                                    captured: charge.captured,
                                                    payer_id: self.sp_id,
                                                    payee_id: self.dm_id
                                                })
    transaction.save
  end

  private

  def send_slack_notification
    if Rails.env.development?


      notification = {
          text: 'New Meeting',
          username: "Awesom-O",
          icon_emoji: ":loudspeaker:",
          fields: [
              {
                  title: 'New Meeting',
                  value: "ID: #{self.id}, CONFIRMATION: #{self.confirmation_number}"
              },
              {
                  title: 'Decision Maker',
                  value: "#{self.dm.full_name} (#{self.dm_id}) - #{self.dm.email} - #{self.dm.phone_number} - #{self.dm.company_name}"
              },
              {
                  title: 'Decision Maker Address',
                  value: "#{self.dm.full_address}"
              },
              {
                  title: 'Salesperson',
                  value: "#{self.sp.full_name} (#{self.sp_id}) - #{self.sp.email} - #{self.sp.phone_number} - #{self.sp.company_name}"
              },
              {
                  title: 'Desired Time',
                  value: "#{self.desired_block.display_day}, between #{self.desired_block.show_start_time} to #{self.desired_block.show_end_time}"
              },
              {
                  title: 'Comments from Salesperson',
                  value: "#{self.sp_requested_comments}"
              }
          ]
      }
      SLACK.ping notification
    end
  end

  def set_confirmation_number
    self.confirmation_number = Digest::SHA1.hexdigest("--#{Time.current.usec}--").slice(0..6).upcase!
  end

end
