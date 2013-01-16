class AddExtIdToPins < ActiveRecord::Migration
  def change
    add_column :pins, :ext_id, :integer
  end
end
