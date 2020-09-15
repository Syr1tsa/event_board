class Event < ApplicationRecord
  belongs_to :user

  validates_presence_of :title, :address, :datetime, :user
  validates :title, length: {maximum: 255}
end
