class Dashboard < ApplicationRecord
  belongs_to :feature_request

  enum status: ['Awaiting Customer Call-Back', 'Awaiting Feature Development', 'To Call', 'To Log Bugs']
end
