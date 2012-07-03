class CreateAccesstokens < ActiveRecord::Migration
  def change
    create_table :accesstokens do |t|
      t.string :value
      t.string :type
      t.integer :user_id

      t.timestamps
    end
  end
end
