class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  validates :image, file_size: { less_than: 1.megabytes }
  # Include default devise modules. Others available are:
  #   :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def badge
    self.tier ? "#{self.tier.downcase}_badge.png" : 'diamond_badge.png'
  end
end
