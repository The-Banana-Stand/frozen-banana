class Meeting < ApplicationRecord
  belongs_to :dm, class_name: 'User'
  belongs_to :sp, class_name: 'User'
  has_one :feedback
end
