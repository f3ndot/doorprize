class AddRankToPopulationsCentres < ActiveRecord::Migration
  def change
    add_column :population_centres, :rank, :integer
  end
end
