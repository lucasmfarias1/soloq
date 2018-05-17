class Profile < ApplicationRecord
  belongs_to :user
  has_many :posts

  mount_uploader :image, ImageUploader
  validates :image, file_size: { less_than: 1.megabytes }

  def badge
    self.tier ? "#{self.tier.downcase}_badge.png" : 'unranked_badge.png'
  end
end
