class AddMarkerColorToLocategories < ActiveRecord::Migration
  def change
    add_column :locategories, :marker_color, :string
  end
end
