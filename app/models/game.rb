class Game < ApplicationRecord
  has_many :competitions

  validates :full_name, :acronym, presence: true
  validates :full_name, :acronym, uniqueness: true
end
