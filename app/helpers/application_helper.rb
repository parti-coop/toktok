module ApplicationHelper
  def byline(user, options={})
    return if user.nil?
    raw render(partial: 'users/byline', locals: options.merge(user: user))
  end

  def static_date_f(date)
    date.strftime("%Y.%m.%d %H:%M")
  end

  def excerpt(text, options = {})
    options[:length] = 130 unless options.has_key?(:length)
    truncate((strip_tags(text).try(:html_safe)), options)
  end

  def upload_file_exists?(file_object)
    file_object.try(:file).try(:exists?)
  end
end
