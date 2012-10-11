class AddMarkerToLocategory < ActiveRecord::Migration
  def change
    add_column :locategories, :marker, :string
  end
end
