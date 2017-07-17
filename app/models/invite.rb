class Invite < ApplicationRecord
  has_paper_trail
  has_attached_file :attachment
  validates_attachment_content_type :attachment, content_type: {content_type: %w(text/csv )}

  belongs_to :user

  validates :first_name, :last_name, :company_name, presence: true

end
