class AddContinentIdToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :continent_id, :integer
  end
end
