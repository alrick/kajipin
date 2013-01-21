class AddSecretToAccesstokens < ActiveRecord::Migration
  def change
    add_column :accesstokens, :secret, :string
  end
end
