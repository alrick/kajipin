class RemoveTypeFromAccesstokens < ActiveRecord::Migration
  def up
    remove_column :accesstokens, :type
  end

  def down
    add_column :accesstokens, :type, :string
  end
end
