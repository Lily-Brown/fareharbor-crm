class FeatureRequest < ApplicationRecord
  has_many :features
  alias_method :identified_features, :features
  has_one :dashboard
  belongs_to :customer
  belongs_to :contact
  alias_method :request_contact, :contact

  validates :name, :request_date, :customer_summary, presence: true
  
  enum status: ['New', 'In Progress', 'Complete']
end
