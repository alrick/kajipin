class AddAccountToAccesstokens < ActiveRecord::Migration
  def change
    add_column :accesstokens, :account, :string
  end
end
