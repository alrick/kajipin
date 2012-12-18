class AddPinIdToLogpages < ActiveRecord::Migration
  def change
    add_column :logpages, :pin_id, :integer
  end
end
