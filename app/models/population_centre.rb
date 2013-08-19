class PopulationCentre < ActiveRecord::Base
  has_many :incidents

  validates :name, presence: true
  validates :rank, presence: true, numericality: { only_integer: true }

  default_scope order('rank ASC')
end
