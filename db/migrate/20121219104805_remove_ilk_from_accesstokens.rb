class RemoveIlkFromAccesstokens < ActiveRecord::Migration
  def up
    remove_column :accesstokens, :ilk
  end

  def down
    add_column :accesstokens, :ilk, :string
  end
end
