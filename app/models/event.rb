class Event < ApplicationRecord
  validates_presence_of :title, :addres, :datetime
  validates :title, length: {maximum: 255}
end
