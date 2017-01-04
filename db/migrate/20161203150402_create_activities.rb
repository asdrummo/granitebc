class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :activity_id
      t.integer :athlete_id
      t.string :name
      t.float :distance
      t.integer :moving_time
      t.integer :elapsed_time
      t.float :total_elevation_gain
      t.float :elev_high
      t.float :elev_low
      t.string :activity_type
      t.datetime :start_date
      t.datetime :start_date_local
      t.string :timezone
      t.string :start_latlng
      t.string :end_latlng
      t.integer :achievement_count
      t.integer :kudos_count
      t.integer :comment_count
      t.integer :athlete_count 
      t.integer :total_photo_count
      t.float :average_speed
      t.float :max_speed
      t.float :calories

      t.timestamps null: false
    end
  end
end
