class Customer < ApplicationRecord
  has_many :feature_requests
  has_many :contacts
  has_one  :primary_contact, -> { where(is_primary: true) }, :class_name=> "Contact"

  validates :name, :street_address, :city, :state, :zip_code, :work_phone, presence: true
  validates :name, uniqueness: true
  validates :work_phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "needs to be in the format xxx-xxx-xxxx" }
  validates :zip_code, format: { with: /\d{5}/, message: "needs to be 5 digits long" }
  validates :state, format: { with: /[A-Z]{2}/, message: "needs to be 2 capital letters representing the state" }
end
