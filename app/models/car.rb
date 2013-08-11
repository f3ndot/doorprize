class Car < ActiveRecord::Base

  belongs_to :incident, autosave: true, touch: true

  validates :incident, presence: true, on: :update
  validate :any_present?

  def to_s
    str = "Vehicle ID No. \##{id}"
    str << " - Licence Plate: #{license_plate}" if license_plate.present?
    return str
  end

  # Make sure that license plates are stored in uppercase
  def license_plate=(plate)
    write_attribute :license_plate, plate.upcase
  end

  protected

  # Validates that at least one attribute in the model is filled out.
  def any_present?
    # Filter out created_at and updated_at coloumns, they don't count
    fields = Car.content_columns.map(&:name).delete_if {|name| name == 'created_at' || name == 'updated_at' }
    if fields.all? { |attr| self[attr].blank? }
      fields.each do |attr|
        errors.add(attr.to_sym, 'You must fill in at least one field')
      end
    end
  end

end
