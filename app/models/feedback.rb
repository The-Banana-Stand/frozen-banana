class Feedback < ApplicationRecord
  belongs_to :dm, class_name: 'User'
  belongs_to :sp, class_name: 'User'
  belongs_to :meeting
end
