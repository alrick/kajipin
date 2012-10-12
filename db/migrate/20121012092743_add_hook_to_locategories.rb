class AddHookToLocategories < ActiveRecord::Migration
  def change
    add_column :locategories, :hook, :integer
  end
end
