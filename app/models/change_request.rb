class ChangeRequest < ApplicationRecord
  has_paper_trail
  belongs_to :user
  belongs_to :meeting
  auto_strip_attributes :request

  validates :request, presence: true
end
