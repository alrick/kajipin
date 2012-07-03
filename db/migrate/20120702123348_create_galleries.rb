class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.integer :location_id

      t.timestamps
    end
  end
end
