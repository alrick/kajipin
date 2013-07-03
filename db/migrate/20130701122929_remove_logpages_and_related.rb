class RemoveLogpagesAndRelated < ActiveRecord::Migration
  def up
    drop_table :logpages
    drop_table :tags
    drop_table :assignments
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
