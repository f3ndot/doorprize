class Incident < ActiveRecord::Base

  has_one :car, autosave: true, dependent: :destroy
  has_many :witnesses, autosave: true, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :car, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :witnesses, allow_destroy: true, reject_if: :all_blank

  MIN_SEVERITY = 0
  MAX_SEVERITY = 10

  MAX_SCORE = 6

  validates :severity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: MIN_SEVERITY, less_than_or_equal_to: MAX_SEVERITY, message: "severity must be between #{MIN_SEVERITY} and #{MAX_SEVERITY}, inclusive" }
  validates :datetime_of_incident, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validate :validate_datetime_of_incident

  # TODO test the ever-living crap out of :by_user scope
  scope :by_user, -> (user_id) { where 'user_id = ?', user_id }
  scope :latest_incidents, -> { order 'datetime_of_incident DESC' }
  scope :oldest_incidents, -> { order 'datetime_of_incident ASC' }
  scope :latest_submitted, -> { order 'created_at DESC' }
  scope :oldest_submitted, -> { order 'created_at ASC' }
  scope :most_severe, -> { order 'severity DESC' }
  scope :least_severe, -> { order 'severity ASC' }

  before_save :calculate_score

  def to_s
    "Incident No. \##{id} - Date: #{datetime_of_incident} - Severity Level #{severity}"
  end

  def short_name
    "No. \##{id}"
  end

  def score
    return score_override if score_override.present?
    read_attribute :score
  end

  def score_percent
    percent = ((score / MAX_SCORE.to_f) * 100)
    percent = 100 if percent > 100
    percent = 0 if percent < 0
    percent.round.to_s << '%'
  end

  # TODO This is a dependency code-smell. Move into Car model
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

  protected

  def validate_datetime_of_incident
    errors.add(:datetime_of_incident, "can't be in the future") if datetime_of_incident.present? && datetime_of_incident.future?
  end

  def calculate_score
    score = 0
    score += 1 if user.present?
    score -= 1 if user.blank?
    if car.present?
      score += 1 if car.license_plate.present?
      score += 1 if car.driver_name.present?
      score += 1 if car.driver_contact.present?
    end
    if witnesses.count > 0
      witness_name_score = false
      witness_score = false
      witnesses.each do |w|
        if w.name.present?
          witness_name_score = true
        end
        if w.name.present? && w.contact.present?
          witness_score = true
        end
      end
      score += 1 if witness_name_score
      score += 1 if witness_score
    end
    score += 3 if video.present?
    score += 1 if police_report_number.present?

    write_attribute :score, score
  end

end
