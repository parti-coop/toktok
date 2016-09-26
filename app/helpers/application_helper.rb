module ApplicationHelper
  def byline(user, options={})
    return if user.nil?
    raw render(partial: 'users/byline', locals: options.merge(user: user))
  end

  def static_date_f(date)
    date.strftime("%Y.%m.%d %H:%M")
  end
end
