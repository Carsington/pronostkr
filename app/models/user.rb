class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :attach_default_image

  has_many :forecasts
  has_many :user_leagues
  has_many :leagues, through: :user_leagues

  private

  def attach_default_image
    self.photo.attach(
      io: File.open(Rails.root.join("app", "assets", "images", "eddy_avatar.png")),
      filename: 'edddy_avatar.png',
      content_type: "image/png"
    )
  end
end
