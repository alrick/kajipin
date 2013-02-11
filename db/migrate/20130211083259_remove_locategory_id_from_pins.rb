class RemoveLocategoryIdFromPins < ActiveRecord::Migration
  def up
    remove_column :pins, :locategory_id
  end

  def down
    add_column :pins, :locategory_id, :integer
  end
end
