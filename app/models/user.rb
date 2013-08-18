class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :omniauthable, :omniauth_providers => [:google_oauth2, :twitter, :github, :facebook]

  def gravatar(size=nil)
    str = "http://www.gravatar.com/avatar/" << Digest::MD5.hexdigest(email.downcase)
    str << "?s=#{size}" if size.present? && size.is_a?(Integer) && size.between?(0,512)
    return str
  end

  USER_LVL = 0
  MOD_LVL = 1
  ADMIN_LVL = 2

  has_many :incidents

  validates :name, presence: true

  def admin?
    read_attribute( :role )== ADMIN_LVL
  end

  def mod?
    read_attribute( :role )== MOD_LVL
  end

  def user?
    read_attribute( :role )== USER_LVL
  end

  def role
    case read_attribute :role
    when USER_LVL
      'User'
    when MOD_LVL
      'Moderator'
    when ADMIN_LVL
      'Administrator'
    else
      'Unknown'
    end
  end

  def get_provider
    case provider
    when 'twitter'
      'Twitter'
    when 'google_oauth2'
      'Google Account'
    when 'github'
      'GitHub'
    when 'facebook'
      'Facebook'
    end
  end

  # Devise and Omniauth methods for authentication
  def self.find_for_twitter_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create name: auth.info.name, provider: auth.provider, uid: auth.uid
    end
    user
  end

  def self.find_for_github_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create name: auth.info.name, email: auth.info.email, provider: auth.provider, uid: auth.uid
    end
    user
  end

  def self.find_for_google_oauth2(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create name: auth.info.name, email: auth.info.email, provider: auth.provider, uid: auth.uid
    end
    user
  end

  def self.find_for_facebook_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create name: auth.info.name, email: auth.info.email, provider: auth.provider, uid: auth.uid
    end
    user
  end

  def self.new_with_session(params, session)
    user_params = params #.require(:user).permit(:name, :email, :password, :password_confirmation, :provider, :uid)

    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.attributes = user_params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
