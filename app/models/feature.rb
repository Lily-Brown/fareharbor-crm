class Feature < ApplicationRecord
  belongs_to :feature_request

  enum status: ['New', 'In Progress', 'Complete']
end
