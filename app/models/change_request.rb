class ChangeRequest < ApplicationRecord
  belongs_to :user
  belongs_to :meeting
  auto_strip_attributes :request
end
