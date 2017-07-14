class Meeting < ApplicationRecord
  belongs_to :dm, class_name: 'User'
  belongs_to :sp, class_name: 'User'
  has_one :feedback

  monetize :price_cents

  def show_start_time
    time_start.strftime('%I:%M%p')
  end

  def show_end_time
    time_end.strftime('%I:%M%p')
  end

end
