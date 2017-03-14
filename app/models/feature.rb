class Feature < ApplicationRecord
  belongs_to :feature_request

  enum status: [:new_feature, :in_progress, :complete]
end
