class AddIndexes < ActiveRecord::Migration
  def change
    add_index :comments, :pin_id
    add_index :logpages, :pin_id
    add_index :galleries, :pin_id
    add_index :pins, :user_id
    add_index :pins, :locategory_id
  end
end
