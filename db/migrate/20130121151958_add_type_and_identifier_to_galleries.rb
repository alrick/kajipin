class AddTypeAndIdentifierToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :type, :string
    add_column :galleries, :identifier, :string
  end
end
