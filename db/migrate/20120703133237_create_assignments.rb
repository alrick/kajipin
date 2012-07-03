class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :logpage_id
      t.integer :tag_id

      t.timestamps
    end
    add_index :assignments, :logpage_id
    add_index :assignments, :tag_id
  end
end
