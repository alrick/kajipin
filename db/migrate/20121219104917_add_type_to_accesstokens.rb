class AddTypeToAccesstokens < ActiveRecord::Migration
  def change
    add_column :accesstokens, :type, :string
  end
end
