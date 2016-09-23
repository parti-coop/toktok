ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'

OmniAuth.config.test_mode = true

class CarrierWave::Mount::Mounter
  def store!
    # Not storing uploads in the tests
  end
end

module CatanTestHelpers
  def fixture_file(flie_name)
    fixture_file_upload(File.join(ActionController::TestCase.fixture_path, flie_name), nil, true)
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include CatanTestHelpers

  ENV["ADMIN_EMAILS"] = "admin@parti.xyz"

  CarrierWave.root = Rails.root.join('test/fixtures/files')
  def after_teardown
    super
    CarrierWave.clean_cached_files!(0)
  end

    # Returns true if a test user is logged in.
  def signed_in?
    !session[:user_id].nil?
  end

  # Logs in a test user.
  def sign_in(user, options = {})
    raise "Not found user" if user.nil? or User.find_by(id: user.id).nil?
    remember_me = options[:remember_me] || '1'
    if integration_test?
      OmniAuth.config.add_mock(user.provider, {uid: user.uid, info: {uid: user.uid}})

      @headers ||= {}
      @headers["omniauth.auth"] = {provider: user.provider, uid: user.uid}
      post send("user_#{user.provider}_omniauth_callback_path"), params: {code: 'test'}, headers: @headers
      follow_redirect!
    else
      session[:user_id] = user.id
    end
  end

  private

  # Returns true inside an integration test.
  def integration_test?
    defined?(post_via_redirect)
  end
end
