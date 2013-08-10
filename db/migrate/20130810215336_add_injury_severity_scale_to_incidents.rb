class AddInjurySeverityScaleToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :severity, :integer
  end
end
