class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.string :name
      t.integer :strava_id
      t.text :picture
      t.float :weekly_mileage
      t.float :alltime_mileage
      t.float :weekly_elevation
      t.float :alltime_elevation
      t.float :max_elevation_gain
      t.float :max_distance
      t.float :max_time
      t.integer :weekly_time
      t.integer :total_time
      t.float :weekly_max_speed
      t.float :alltime_max_speed
      t.integer :sessions

      t.timestamps null: false
    end
  end
end
