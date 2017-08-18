class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

end
