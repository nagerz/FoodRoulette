class PhoneNumber < ApplicationRecord
  belongs_to :survey
  belongs_to :vote
end
