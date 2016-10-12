module ApplicationHelper
  def byline(user, options={})
    return if user.nil?
    raw render(partial: 'users/byline', locals: options.merge(user: user))
  end

  def static_date_f(date)
    date.strftime("%Y.%m.%d %H:%M")
  end

  def static_date_f_not_hour(date)
    date.strftime("%Y-%m-%d")
  end

  def smart_format(text, html_options = {}, options = {})
    parsed_text = simple_format(h(text), html_options, options).to_str
    raw(auto_link(parsed_text,
      html: {class: 'auto_link', target: '_blank'},
      link: :urls,
      sanitize: false))
  end

  def excerpt(text, options = {})
    options[:length] = 130 unless options.has_key?(:length)
    truncate((strip_tags(text).try(:html_safe)), options)
  end

  def upload_file_exists?(file_object)
    file_object.try(:file).try(:exists?)
  end

  def date_f(date)
    timeago_tag date, lang: :ko, limit: 100.days.ago
  end

  def project_status_text(project)
    t("messages.project_status.#{project.status}")
  end

  def bar_count_of_project(project)
    bar_count = (1 + ((project.participations_percentage - 1)/100))
    bar_count = 1 if project.participations_percentage == 0
    return bar_count
  end

  def is_redactorable?
    !browser.device.mobile? and !browser.device.tablet?
  end

  def has_error_attr?(object, name)
    object.respond_to?(:errors) && !(name.nil? || object.errors[name.to_s].empty?)
  end

  def error_class_str(object, name)
    'has-error' if has_error_attr?(object, name)
  end

  def error_messages(object, name)
    return unless has_error_attr?(object, name)
    return raw object.errors[name].join('<br>')
  end
end
