class RemoveDanglingReferenceFromIncidents < ActiveRecord::Migration
  def change
    remove_reference(:incidents, :population_centres, {:index=>true})
  end
end
