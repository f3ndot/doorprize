class CreatePopulationCentres < ActiveRecord::Migration
  def change
    create_table :population_centres do |t|
      t.string :city
      t.string :province
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
