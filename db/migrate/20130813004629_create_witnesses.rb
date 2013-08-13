class CreateWitnesses < ActiveRecord::Migration
  def change
    create_table :witnesses do |t|
      t.string :name
      t.text :contact
      t.integer :privacy_level

      t.timestamps
    end
  end
end
