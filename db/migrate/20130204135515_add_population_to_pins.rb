class AddPopulationToPins < ActiveRecord::Migration
  def change
    add_column :pins, :population, :integer
  end
end
