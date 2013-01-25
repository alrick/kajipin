class AddUidToAccesstokens < ActiveRecord::Migration
  def change
    add_column :accesstokens, :uid, :integer
  end
end
