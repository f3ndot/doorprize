class AddLatitudeAndLongitudeToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :latitude, :float
    add_column :incidents, :longitude, :float
  end
end
