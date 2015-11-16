class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.integer :stop_id
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.string :direction
      t.integer :previous
      t.integer :trueTime
      t.integer :avgTime
      t.timestamps null: false
    end
  end
end
