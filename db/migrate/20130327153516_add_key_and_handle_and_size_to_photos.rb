class AddKeyAndHandleAndSizeToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :key, :string
    add_column :photos, :handle, :string
    add_column :photos, :size, :integer
  end
end
