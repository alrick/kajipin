class AddTypeToPins < ActiveRecord::Migration
  def change
    add_column :pins, :type, :string
    add_index :pins, :type
  end
end
