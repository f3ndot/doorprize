class PopulationCentre < ActiveRecord::Base
  has_many :incidents

  validates :city, presence: true
  validates :province, presence: true
  validates :rank, presence: true, numericality: { only_integer: true }

  def name
    "#{city}, #{province}"
  end

  default_scope order('rank ASC')
end
