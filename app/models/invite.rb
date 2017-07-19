class Invite < ApplicationRecord
  has_paper_trail
  has_attached_file :attachment
  validates_attachment_content_type :attachment, :content_type => %w(application/zip application/msword application/vnd.ms-office application/vnd.ms-excel application/vnd.openxmlformats-officedocument.spreadsheetml.sheet text/csv text/plain)
  validates_attachment_size :attachment, :in => 0.megabytes..2.megabytes

  belongs_to :user

  validates :first_name, :last_name, :company_name, presence: true

end
