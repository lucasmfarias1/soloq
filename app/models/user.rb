class User < ApplicationRecord
  has_one :profile
  # Include default devise modules. Others available are:
  #   :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
