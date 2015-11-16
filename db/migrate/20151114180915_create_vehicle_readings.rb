class CreateVehicleReadings < ActiveRecord::Migration
  def change
    create_table :vehicle_readings do |t|
      t.integer :reading_id
      t.integer :current_stop_id
      t.integer :heading
      t.integer :vehicle_id
      t.decimal :latitude
      t.decimal :longitude
      t.integer :speed
      t.bigint :timestamp
      t.timestamps null: false
    end
  end
end
