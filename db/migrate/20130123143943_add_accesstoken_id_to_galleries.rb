class AddAccesstokenIdToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :accesstoken_id, :integer
  end
end
