class Meeting < ApplicationRecord
  has_many :teams
  has_many :feature_requests
  
  validates :name, :agenda, :date, :time, :location, presence: true
end
