class Photo < ActiveRecord::Base

  belongs_to :incident
  mount_uploader :image, PhotoUploader

end
