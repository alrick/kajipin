class AddContinentCodeToPins < ActiveRecord::Migration
  def change
    add_column :pins, :continent_code, :string
  end
end
