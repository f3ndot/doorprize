class Car < ActiveRecord::Base

  belongs_to :incident

  validates :description, presence: true

  # Make sure that license plates are stored in uppercase
  def license_plate=(plate)
    write_attribute :license_plate, plate.upcase
  end

end
