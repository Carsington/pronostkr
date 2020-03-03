class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo

  has_many :user_leagues, dependent: :destroy
  has_many :leagues, through: :user_leagues
  has_many :forecasts, dependent: :destroy

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def already_joined?(league)
    UserLeague.exists?(user: self, league: league)
  end
end
