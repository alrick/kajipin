class RemoveTitleAndNormalizedFromGalleries < ActiveRecord::Migration
  def up
    remove_column :galleries, :title
    remove_column :galleries, :normalized
  end

  def down
    add_column :galleries, :title, :string
    add_column :galleries, :normalized, :string
  end
end
