class FixAccesstokenValue < ActiveRecord::Migration
  def change
    rename_column :accesstokens, :value, :token
  end
end
