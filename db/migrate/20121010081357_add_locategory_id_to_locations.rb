class AddLocategoryIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :locategory_id, :int
  end
end
