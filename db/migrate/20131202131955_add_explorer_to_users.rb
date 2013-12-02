class AddExplorerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :explorer, :boolean, :null => false, :default => false
  end
end
