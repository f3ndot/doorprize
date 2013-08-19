class AddNameToPopulationCentres < ActiveRecord::Migration
  def change
    add_column :population_centres, :name, :string
  end
end
