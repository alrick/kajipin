class AddIndexToPhotos < ActiveRecord::Migration
  def change
    add_index :photos, :pin_id
  end
end
