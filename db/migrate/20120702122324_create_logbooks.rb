class CreateLogbooks < ActiveRecord::Migration
  def change
    create_table :logbooks do |t|
      t.text :description
      t.integer :location_id

      t.timestamps
    end
  end
end
