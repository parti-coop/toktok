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
end
