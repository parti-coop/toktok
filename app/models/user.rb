class User < ApplicationRecord
  extend Enumerize
  enumerize :role, in: [:citizen, :staff]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :confirmable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :omniauthable,
         :omniauth_providers => [:facebook, :twitter, :kakao]

  has_many :proposals, dependent: :destroy
  has_many :projects
  has_many :participations, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # validations
  VALID_NICKNAME_REGEX = /\A[ㄱ-ㅎ가-힣a-z0-9_]+\z/i

  validates :nickname,
    presence: true,
    exclusion: { in: %w(app new edit index session login logout users admin all issue group campaign) },
    format: { with: VALID_NICKNAME_REGEX },
    uniqueness: { case_sensitive: false },
    length: { maximum: 20 }
  validate :nickname_exclude_pattern
  validates :email,
    presence: true,
    format: { with: Devise.email_regexp },
    uniqueness: {scope: [:provider]}
  validates :uid, uniqueness: {scope: [:provider]}
  validates :password,
    presence: true,
    confirmation: true,
    length: Devise.password_length,
    if: :password_required?

  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: Devise.password_length, allow_blank: true

  # scopes
  scope :staffs, -> { where(role: :staff) }

  # filters
  before_save :downcase_nickname
  before_save :set_uid
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
      resource.password = Devise.friendly_token[0,20]
      resource.confirmed_at = DateTime.now
      resource.remote_image_url = auth['image']
    else
      resource.provider = 'email'
    end
    resource
  end

  def self.find_for_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first
  end

  # email auth

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    email = conditions.delete(:email)
    where(conditions.to_h).where(["provider = 'email' AND uid = :value", { :value => email.downcase }]).first
  end

  # for recovering the password for an account
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    unless conditions.has_key?(:confirmation_token)
      conditions.merge! provider: 'email'
    end
    where(conditions.to_h).first
  end

  private

  def set_uid
    self.uid = self.email if self.provider == 'email'
  end

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

  def password_required?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end
end
