class FeatureRequest < ApplicationRecord
  has_many :features
  alias_method :identified_features, :features
  belongs_to :customer
  belongs_to :contact
  alias_method :request_contact, :contact

  enum status: [:new_feature_request, :in_progress, :complete]
end
