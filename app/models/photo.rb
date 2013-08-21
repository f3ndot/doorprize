class Photo < ActiveRecord::Base

  belongs_to :incident
  mount_uploader :image, PhotoUploader

  validates :image, presence: true

  before_destroy :delete_image_from_store

  protected

  def delete_image_from_store
    remove_image
  end

end
