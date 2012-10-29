class FixTypeNameFromAccesstokens < ActiveRecord::Migration
  def change
    rename_column :accesstokens, :type, :ilk
  end
end
