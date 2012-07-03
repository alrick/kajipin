class CreateLogpages < ActiveRecord::Migration
  def change
    create_table :logpages do |t|
      t.string :title
      t.text :content
      t.integer :logbook_id
      t.integer :category_id

      t.timestamps
    end
  end
end
