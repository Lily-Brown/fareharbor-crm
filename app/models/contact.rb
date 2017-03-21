class Contact < ApplicationRecord
  belongs_to :customer
  has_many :feature_requests

  validates :first_name, :last_name, :title, :work_phone, :email_address, presence: true
  validates :work_phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "needs to be in the format xxx-xxx-xxxx" }
end
