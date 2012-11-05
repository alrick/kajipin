class RenameLocationsToPins < ActiveRecord::Migration
  def self.up
    rename_table :locations, :pins
    rename_column :comments, :location_id, :pin_id
    rename_column :galleries, :location_id, :pin_id
    rename_column :logbooks, :location_id, :pin_id
  end

  def self.down
    rename_table :pins, :locations
    rename_column :comments, :pin_id, :location_id
    rename_column :galleries, :pin_id, :location_id
    rename_column :logbooks, :pin_id, :location_id
  end
end
