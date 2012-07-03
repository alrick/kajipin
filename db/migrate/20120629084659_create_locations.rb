class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :title
      t.string :subtitle
      t.float :latitude
      t.float :longitude
      t.integer :user_id

      t.timestamps
    end
  end
end
