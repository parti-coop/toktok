class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :registerable, :rememberable, :trackable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter]
  # validations
  VALID_NICKNAME_REGEX = /\A[ㄱ-ㅎ가-힣a-z0-9_]+\z/i

  validates :nickname,
    presence: true,
    exclusion: { in: %w(app new edit index session login logout users admin all issue group campaign) },
    format: { with: VALID_NICKNAME_REGEX },
    uniqueness: { case_sensitive: false },
    length: { maximum: 20 }
  validate :nickname_exclude_pattern

  # filters
  before_save :downcase_nickname
  before_validation :strip_whitespace_nickname, only: :nickname

  # mount
  mount_uploader :image, UserImageUploader

  # methods for devises/auth
  def self.parse_omniauth(data)
    {provider: data['provider'], uid: data['uid'], email: data['info']['email'], image: data['info']['image']}
  end

  def self.new_with_session(params, session)
    resource = super
    auth = session["devise.omniauth_data"]
    if auth.present?
      auth["email"] = params['email'] if params['email'].present?
      resource.assign_attributes(auth)
      resource.remote_image_url = auth['image']
    end
    resource
  end

  def self.find_for_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first
  end

  # the other methods

  def admin?
    %w(account@parti.xyz).include? email
  end

  private

  def downcase_nickname
    self.nickname = nickname.downcase
  end

  def nickname_exclude_pattern
    if (self.nickname =~ /\Aparti.*\z/i) and (self.nickname_was !~ /\Aparti.*\z/i)
      errors.add(:nickname, I18n.t('errors.messages.taken'))
    end
  end

  def strip_whitespace_nickname
    self.nickname = self.nickname.strip unless self.nickname.nil?
  end
end
