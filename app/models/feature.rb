class Feature < ApplicationRecord
  belongs_to :feature_request

  validates :name, :bug_request, presence: true

  enum status: ['New', 'In Progress', 'Complete']
end
