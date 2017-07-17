class Invite < ApplicationRecord
  has_paper_trail

  belongs_to :user

  validates :first_name, :last_name, :company_name, presence: true

end
