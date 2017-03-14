class Customer < ApplicationRecord
  has_many :feature_requests
  has_many :contacts
  has_one  :primary_contact, -> { where(is_primary: true) }, :class_name=> "Contact"

end
