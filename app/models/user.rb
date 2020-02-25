class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_leagues, dependent: :destroy
  has_many :leagues, through: :user_leagues
  has_many :forecasts, dependent: :destroy
end
