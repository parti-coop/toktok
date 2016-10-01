class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :prepare_meta_tags, if: "request.get?"
  after_action :prepare_unobtrusive_flash
  after_action :store_location

  if Rails.env.production? or Rails.env.staging?
    rescue_from ActiveRecord::RecordNotFound, ActionController::UnknownFormat do |exception|
      render_404
    end
    rescue_from CanCan::AccessDenied do |exception|
      self.response_body = nil
      redirect_to root_url, :alert => exception.message
    end
    rescue_from ActionController::InvalidCrossOriginRequest, ActionController::InvalidAuthenticityToken do |exception|
      self.response_body = nil
      redirect_to root_url, :alert => I18n.t('errors.messages.invalid_auth_token')
    end
  end

  def render_404
    self.response_body = nil
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def errors_to_flash(model)
    flash[:notice] = model.errors.full_messages.join('<br>').html_safe
  end

  def prepare_meta_tags(options={})
    set_meta_tags build_meta_options(options)
  end

  def build_meta_options(options)
    site_name = "국회톡톡"
    title = "하고 싶은 말, 국회톡톡으로 의원에게 직접 톡으로 하자!"
    image = options[:image] || view_context.image_url('seo.png')
    url = options[:url] || root_url

    description = "시민의 제안으로 법안을 만듭니다. 지금 참여해서 시민의 제안을 국회로 연결해주세요!"
    {
      title:       title,
      reverse:     true,
      image:       image,
      description: description,
      keywords:    "시민, 정치, 국회, 입법, 법안, 20대국회, 온라인정치, 정치참여, 국회톡톡, 시민입법, 빠띠, 빠흐띠, 와글",
      canonical:   url,
      twitter: {
        site_name: site_name,
        site: '@parti_xyz',
        card: 'summary',
        title: title,
        description: description,
        image: image
      },
      og: {
        url: url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }
  end

  def redirect_back_with_anchor(anchor:, fallback_location:, **args)
    if referer = request.headers["Referer"]
      redirect_to "#{referer}##{anchor}", **args
    else
      redirect_to fallback_location, **args
    end
  end

  private

  def store_location
    return unless request.get?
    return if params[:controller].blank?
    return if params[:controller].match("users/")
    return if params[:controller].match("devise/")
    return if params[:controller] == "users" and params[:action] == "join"
    return if request.xhr?

    store_location_for(:user, request.fullpath)
  end
end
