class RenameSmallcityToTown < ActiveRecord::Migration
  def up
    Pin.where(:type => 'Smallcity').update_all("type = 'Town'")
  end

  def down
    Pin.where(:type => 'Town').update_all("type = 'Smallcity'")
  end
end
