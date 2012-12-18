class DropLogbooksTable < ActiveRecord::Migration
  def up
    drop_table :logbooks
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
