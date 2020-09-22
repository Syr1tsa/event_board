class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  REGEX_FOR_EMAIL = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/

  has_many :events
  has_many :comments

  validates :name, presence: true, length: {maximum: 35}
  validates :email, uniqueness: true, presence: true, length: {maximum: 255},
            format: REGEX_FOR_EMAIL

  before_validation :set_name, on: :create

  private

  def set_name
    self.name = "Товарищ #{rand(777)}" if self.name.blank?
  end
end
