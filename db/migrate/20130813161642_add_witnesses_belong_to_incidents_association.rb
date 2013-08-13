class AddWitnessesBelongToIncidentsAssociation < ActiveRecord::Migration
  def change
    add_reference :witnesses, :incident, index: true
  end
end
