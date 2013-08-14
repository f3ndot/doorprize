class AddIncidentsAssociationToUsers < ActiveRecord::Migration
  def change
    add_reference :incidents, :user, index: true
  end
end
