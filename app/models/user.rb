class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #   :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def badge
    self.tier ? "#{self.tier.downcase}_badge.png" : 'diamond_badge.png'
  end
end
