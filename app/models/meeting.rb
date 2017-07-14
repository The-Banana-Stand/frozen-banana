class Meeting < ApplicationRecord
  belongs_to :dm, class_name: 'User'
  belongs_to :sp, class_name: 'User'
  belongs_to :general_availability
  belongs_to :desired_block, class_name: 'GeneralAvailability', foreign_key: 'general_availability_id'
  has_one :feedback

  attr_accessor :role, :second_party

  monetize :price_cents


  def show_start_time
    time_start ? time_start.strftime('%I:%M%p') : 'Pending'
  end

  def show_end_time
    time_end ? time_end.strftime('%I:%M%p') : 'Pending'
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

end
