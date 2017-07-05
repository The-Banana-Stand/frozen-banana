class User < ApplicationRecord
  has_secure_password
  has_many :general_availabilities
  has_many :dm_feedbacks, foreign_key: :dm_id, class_name: 'Feedback'
  has_many :sp_feedbacks, foreign_key: :sp_id, class_name: 'Feedback'

  has_many :dm_meetings, foreign_key: :dm_id, class_name: 'Meeting'
  has_many :sp_meetings, foreign_key: :sp_id, class_name: 'Meeting'


  before_save {self.email = email.downcase}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

end
