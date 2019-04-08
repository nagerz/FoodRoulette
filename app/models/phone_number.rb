class PhoneNumber < ApplicationRecord
  belongs_to :survey
  has_one :vote
end
