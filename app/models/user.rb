class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, length: {maximum: 35}
  validates :email, uniqueness: true, length: {maximum: 255},
            format: REGEX_FOR_EMAIL

  before_validation :set_name, on: :create

  after_commit :link_subscribtions, on: :create

  private

  def set_name
    self.name = "Товарищ #{rand(777)}" if self.name.blank?
  end

  def link_subscribtions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end
end
