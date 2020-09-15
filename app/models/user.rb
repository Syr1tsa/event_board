class User < ApplicationRecord
  REGEX_FOR_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  has_many :events

  validates :name, presence: true, length: {maximum: 35}
  validates :email, uniqueness: true, presence: true, length: {maximum: 255},
            format: REGEX_FOR_EMAIL
end
