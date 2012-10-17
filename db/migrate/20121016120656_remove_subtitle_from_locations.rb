class RemoveSubtitleFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :subtitle
  end

  def down
    add_column :locations, :subtitle, :string
  end
end
