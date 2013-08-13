class RemoveInjuredFromIncidents < ActiveRecord::Migration
  def change
    remove_column :incidents, :injured
  end
end
