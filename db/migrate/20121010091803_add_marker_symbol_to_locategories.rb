class AddMarkerSymbolToLocategories < ActiveRecord::Migration
  def change
    add_column :locategories, :marker_symbol, :string
  end
end
