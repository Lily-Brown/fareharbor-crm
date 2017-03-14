class Customer < ApplicationRecord
  has_many :feature_requests
  has_one :contact
  alias_method :primary_contact, :contact

end
