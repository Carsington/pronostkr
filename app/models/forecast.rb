class Forecast < ApplicationRecord
  belongs_to :user
  belongs_to :match
  belongs_to :team
end
