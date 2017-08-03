class Level < ApplicationRecord
  before_validation :generate_friendly_id, :on => :create

  mount_uploader :image, ImageUploader

  def to_param
    self.friendly_id
  end

  validates :title, presence: true
  validates :friendly_id, presence: true

  validates_uniqueness_of :friendly_id
  validates_format_of :friendly_id, :with => /\A[a-z0-9\-]+\z/

  has_many :challenges

  protected

  def generate_friendly_id
    self.friendly_id ||= SecureRandom.uuid
  end

end
