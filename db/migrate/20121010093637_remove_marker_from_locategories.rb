class RemoveMarkerFromLocategories < ActiveRecord::Migration
  def up
    remove_column :locategories, :marker
  end

  def down
    add_column :locategories, :marker, :string
  end
end
