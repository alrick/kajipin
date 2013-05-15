class RemoveBirthAndSexFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :birth
    remove_column :users, :sex
  end

  def down
    add_column :users, :sex, :string
    add_column :users, :birth, :date
  end
end
