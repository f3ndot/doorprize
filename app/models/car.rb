class Car < ActiveRecord::Base

  belongs_to :incident

  validates :description, presence: true

  # Make sure that license plates are stored in uppercase
  def licence_plate=(plate)
    write_attribute :licence_plate, plate.upcase
  end

end
