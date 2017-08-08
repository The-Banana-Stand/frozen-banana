class GeneralAvailability < ApplicationRecord
  has_paper_trail
  belongs_to :user, :inverse_of => :general_availabilities

  def display_day
    %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)[self.day - 1]
  end

  def show_start_time
    start_time ? start_time.strftime('%l:%M%p') : ''
  end

  def show_end_time
    end_time ? end_time.strftime('%l:%M%p') : ''
  end

end
