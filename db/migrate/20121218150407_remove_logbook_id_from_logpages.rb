class RemoveLogbookIdFromLogpages < ActiveRecord::Migration
  def up
    remove_column :logpages, :logbook_id
  end

  def down
    add_column :logpages, :logbook_id, :integer
  end
end
