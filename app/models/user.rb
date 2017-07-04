class User < ApplicationRecord
  has_secure_password
  has_many :general_availabilities
  has_many :dm_feedbacks, foreign_key: :dm_id, class_name: 'Feedback'
  has_many :sp_feedbacks, foreign_key: :sp_id, class_name: 'Feedback'

  has_many :dm_meetings, foreign_key: :dm_id, class_name: 'Meeting'
  has_many :sp_meetings, foreign_key: :sp_id, class_name: 'Meeting'
end
