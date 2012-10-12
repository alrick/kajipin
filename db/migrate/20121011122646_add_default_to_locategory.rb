class AddDefaultToLocategory < ActiveRecord::Migration
  def change
    add_column :locategories, :default, :boolean
  end
end
