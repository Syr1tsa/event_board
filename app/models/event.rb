class Event < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates_presence_of :title, :address, :datetime, :user
  validates :title, length: {maximum: 255}
end
