class PopulationCentre < ActiveRecord::Base
  default_scope order('rank ASC')

  validates :name, presence: true
  validates :rank, presence: true, numericality: { only_integer: true }
end
