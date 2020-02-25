class Competition < ApplicationRecord
  belongs_to :game
  has_many :matches
  has_many :leagues
end
