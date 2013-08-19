class AddAssociationToIncidents < ActiveRecord::Migration
  def change
    add_reference :incidents, :population_centre, index: true
  end
end
