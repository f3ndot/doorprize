class RemoveNameColumnFromPopulationCentres < ActiveRecord::Migration
  def change
    remove_column :population_centres, :name, :string
  end
end
