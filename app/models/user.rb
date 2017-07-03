class User < ApplicationRecord
  has_many :general_availabilities
  has_many :dm_feedbacks, foreign_key: :dm_id, class_name: 'Feedback'
  has_many :sp_feedbacks, foreign_key: :sp_id, class_name: 'Feedback'
end
