class RenameBigcityToCity < ActiveRecord::Migration
  def up
    Pin.where(:type => 'Bigcity').update_all("type = 'City'")
  end

  def down
    Pin.where(:type => 'City').update_all("type = 'Bigcity'")
  end
end
