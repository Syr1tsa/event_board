module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def errors_messages()
    resource.errors.full_messages.each do |message|
      concat(content_tag(:div, message, class: "alert btn-danger my-btn", role: "alert") do
                concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
      nil
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: "alert") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  def user_avatar(user)
    return user.avatar.url if user.avatar?
    asset_path('user.png')
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path('event.jpg')
    end
  end

  # Возвращает миниатюрную версию фотки
  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_path('user.png')
    end
  end
end
