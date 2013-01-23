class FixGalleriesIdentifierColumn < ActiveRecord::Migration
  def change
    rename_column :galleries, :identifier, :normalized
  end
end
