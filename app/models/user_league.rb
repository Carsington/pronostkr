class UserLeague < ApplicationRecord
  belongs_to :user
  belongs_to :league

  validates :user, :league, presence: true
  validates :user, uniqueness: { scope: :league, message: "can belong only once per league" }
  # validates :is_owner is true exactly once per league
end
