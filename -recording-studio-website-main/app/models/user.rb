class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks

  validates :email, presence: true
  validates_associated :tasks
  validates :password, length: { in: 6..30 }
  validates :email, uniqueness: true
end
