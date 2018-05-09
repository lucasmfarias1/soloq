class Profile < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImageUploader
  validates :image, file_size: { less_than: 1.megabytes }

  def badge
    self.tier ? "#{self.tier.downcase}_badge.png" : 'diamond_badge.png'
  end
end
