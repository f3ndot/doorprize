class AddColumnsToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :score_override, :integer, default: nil
    add_column :incidents, :score, :integer
  end
end
