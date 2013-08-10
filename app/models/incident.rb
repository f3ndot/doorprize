class Incident < ActiveRecord::Base

  MIN_SEVERITY = 0
  MAX_SEVERITY = 10

  validates :severity, numericality: { only_integer: true, greater_than_or_equal_to: MIN_SEVERITY, less_than_or_equal_to: MAX_SEVERITY }

  def severity_text
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
      raise RangeError, "Not a valid severity range. Must be between #{MIN_SEVERITY} and #{MAX_SEVERITY}"
    end
  end

end
