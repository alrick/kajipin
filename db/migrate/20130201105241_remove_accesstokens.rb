class RemoveAccesstokens < ActiveRecord::Migration
  def change
    drop_table :accesstokens
  end
end
