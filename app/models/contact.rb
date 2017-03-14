class Contact < ApplicationRecord
  belongs_to :customer
  has_many :feature_requests

end
