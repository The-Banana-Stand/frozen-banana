class Meeting < ApplicationRecord
  has_paper_trail
  belongs_to :dm, class_name: 'User'
  belongs_to :sp, class_name: 'User'
  belongs_to :general_availability
  belongs_to :desired_block, class_name: 'GeneralAvailability', foreign_key: 'general_availability_id'
  has_one :feedback
  has_many :change_requests

  attr_accessor :role, :second_party

  monetize :price_cents


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

  def sort_priority
    {
        'scheduled' => 1,
        'requested' => 2,
        'completed' => 3
    }[self.status] || 99
  end

  def show_start_time
    time_start ? time_start.strftime('%l:%M%p') : 'Pending'
  end

  def show_end_time
    time_end ? time_end.strftime('%l:%M%p') : 'Pending'
  end

  def show_date
    self.date || 'Pending'
  end

  def set_display_attributes(id)
    self.role = display_role(id)
    self.second_party = meeting_with(id)
  end

  def display_role(id)
    if id == dm_id
      'Decision Maker'
    else
      'Salesperson'
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
        'requested' => 'custom-warning',
        'scheduled' => 'custom-success',
    }[status]
  end

  def capture_payment
    puts 'HELLO FROM CAPTURE PAYMENT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    return if self.payment_status == 'captured'
    customer = self.sp.stripe_customer
    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => price_cents,
        :description => "Charge for Meeting ##{self.id}",
        :currency    => 'usd'
    )

    if charge.status == 'succeeded'
      self.update_attribute(:payment_status, 'captured')
    end
  end

end
