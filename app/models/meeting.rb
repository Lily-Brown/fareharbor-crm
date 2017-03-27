class Meeting < ApplicationRecord
  has_many :teams
  has_many :feature_requests
  
end
