class CreateHeralds < ActiveRecord::Migration
  def change
    create_table :heralds do |t|
      t.integer :user_id
      t.string :key

      t.timestamps
    end
    add_index :heralds, :user_id
  end
end
