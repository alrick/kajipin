class CreateLocategories < ActiveRecord::Migration
  def change
    create_table :locategories do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
