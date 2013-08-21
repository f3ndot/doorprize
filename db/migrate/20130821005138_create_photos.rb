class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|

      t.string  "image"
      t.text  "description"

      t.timestamps
    end
    add_reference :photos, :incident, index: true
  end
end
