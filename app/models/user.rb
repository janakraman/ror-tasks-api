class User < ApplicationRecord
  has_secure_password
  has_many :tasks
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
end
