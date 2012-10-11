class AddMarkerSizeToLocategories < ActiveRecord::Migration
  def change
    add_column :locategories, :marker_size, :string
  end
end
