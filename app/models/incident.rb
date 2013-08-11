class Incident < ActiveRecord::Base

  has_one :car, autosave: true, dependent: :destroy, validate: true
  accepts_nested_attributes_for :car, allow_destroy: true

  MIN_SEVERITY = 0
  MAX_SEVERITY = 10

  validates :severity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: MIN_SEVERITY, less_than_or_equal_to: MAX_SEVERITY, message: "severity must be between #{MIN_SEVERITY} and #{MAX_SEVERITY}, inclusive" }

  def to_s
    "Incident No. \##{id} - Date: #{datetime_of_incident} - Severity Level #{severity}"
  end

  def short_name
    "No. \##{id}"
  end

  def car_licence
    if car.present?
      return "No. \##{car.id}" if car.license_plate.blank?
      car.license_plate
    end
  end

  def severity_text
    Incident.severity_text(severity)
  end

  def severity_color
    Incident.severity_color(severity)
  end

  def self.severity_text(severity)
    case severity
    when 0..1
      'Little to no injury. Scuffs and scrapes'
    when 2..3
      'Hurt. Cuts, bruises. Will probably follow up with doctor'
    when 4..5
      'Injured. Something may be broken or sprained. Blood from cuts.'
    when 6..7
      'Heavily injured. Incapacitated. Ambulance needed'
    when 8..9
      'Severely injured. May be life threatening.'
    when 10
      'Life in imminent danger or death'
    else
      'Unknown severity'
    end
  end

  def self.severity_color(severity)
    case severity
    when 0..1
      '#bfc053'
    when 2..3
      '#c0af53'
    when 4..5
      '#c09853'
    when 6..7
      '#c08153'
    when 8..9
      '#b94a48'
    when 10
      '#c60000'
    else
      '#3a87ad'
    end
  end

end
