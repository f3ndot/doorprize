class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.text :description
      t.string :make
      t.string :color
      t.string :license_plate
      t.string :damage
      t.belongs_to :incident, index: true
      t.string :driver_name
      t.text :driver_contact

      t.timestamps
    end
  end
end
