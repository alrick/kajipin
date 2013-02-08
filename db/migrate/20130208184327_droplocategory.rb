class Droplocategory < ActiveRecord::Migration
  def change
    drop_table :locategories
  end
end
