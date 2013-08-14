class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  def gravatar(size=nil)
    str = "http://www.gravatar.com/avatar/" << Digest::MD5.hexdigest(email.downcase)
    str << "?s=#{size}" if size.present? && size.is_a?(Integer) && size.between?(0,512)
    return str
  end

  has_many :incidents
end
