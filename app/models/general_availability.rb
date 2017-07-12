class GeneralAvailability < ApplicationRecord
  belongs_to :user

  def display_day
    %w(Monday Tuesday Wednesday Thursday Friday Saturday Sunday)[self.day - 1]
  end

end
