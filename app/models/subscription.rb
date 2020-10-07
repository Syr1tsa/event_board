class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: REGEX_FOR_EMAIL, unless: -> { user.present? }

  # my validations
  validate :user_email_present
  validate :user_own_event

  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  private

  # my validations

  def user_own_event
    if user&.events&.include?(event)
      errors.add(:user, I18n.t("activerecord.models.errors.user_own_event"))
    end
  end

  def user_email_present
    if User.where(email: user_email.downcase).present?
      errors.add(:user_email, I18n.t("activerecord.models.errors.email_already_exist"))
    end
  end
end
