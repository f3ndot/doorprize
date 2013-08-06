class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.text :description
      t.datetime :datetime_of_incident
      t.string :location
      t.boolean :injured
      t.string :police_report_number
      t.string :video

      t.timestamps
    end
  end
end
