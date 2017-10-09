class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  before_validation :uniq_username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable


  mount_uploader :avatar, AvatarUploader

  def is_admin?
    self.role == "admin"
  end

  def display_name
    if self.username.present?
      self.username
    else
      self.email.split("@").first
    end
  end

  GENDER = ["Male", "Female"]
  validates_inclusion_of :gender, :in => GENDER

  validates :username, presence: true, length: {maximum: 25}

  has_many :identities

  def self.from_google(access_token, signed_in_resource=nil)
  	data = access_token.info
  	identity = Identity.find_by(:provider => access_token.provider, :uid => access_token.uid)

  	if identity
  		return identity.user
  	else
  		user = User.find_by(:email => access_token.email)
  		if !user
  			user = User.create(
  				username: data["name"],
  				email: data["email"],
  				avatar: MiniMagick::Image.open(data["image"]),
  				password: Devise.friendly_token[0,20],
          gender: "Female",
  			)
  		end
			identity = Identity.create(
				provider: access_token.provider,
				uid: access_token.uid,
				user: user
			)
		return user
  	end
  end

  def self.from_facebook(access_token, signed_in_resoruce=nil)
		data = access_token.info
		identity = Identity.find_by(provider: access_token.provider, uid: access_token.uid)

		if identity
			return identity.user
		else
			user = User.find_by(:email => data.email)
			if !user
				user = User.create!(
					username: access_token.extra.raw_info.name,
					email: data.email,
					avatar: MiniMagick::Image.open(process_uri(data.image)),
					password: Devise.friendly_token[0,20],
          gender: "Female",
				)
			end
			identity = Identity.create(
				provider: access_token.provider,
				uid: access_token.uid,
				user: user
			)
			return user
		end
  end



  private

  def self.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end

  def uniq_username(name = self.username)
    if User.find_by(username: name)
      self.update_attributes(username: (name + rand(1000).to_s))
    end
  end


end
