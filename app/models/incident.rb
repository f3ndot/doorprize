class Incident < ActiveRecord::Base

  validates :severity, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

end
