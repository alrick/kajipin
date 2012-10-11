Tag.delete_all
Tag.create!(:name => "Building", :description => "Can be a museum, a factory, etc.")
Tag.create!(:name => "Event", :description => "Maybe the FIFA world cup?")
Tag.create!(:name => "Exploration", :description => "Indiana Jones would use this.")
Tag.create!(:name => "Food", :description => "Can be a restaurant, a hot dog vendor, etc.")
Tag.create!(:name => "Monument", :description => "Eiffel tower and Wall of China are munuments.")
Tag.create!(:name => "Music", :description => "Can be a festival, a concert, etc.")
Tag.create!(:name => "Must", :description => "A place that you highly recommend.")
Tag.create!(:name => "Nights out", :description => "Because we're social.")
Tag.create!(:name => "Relation", :description => "That's your encounters.")
Tag.create!(:name => "Relaxation", :description => "Can be a beach, a swimming pool, etc.")
Tag.create!(:name => "Shopping", :description => "Because traveling is a good reason to spend some money.")
Tag.create!(:name => "Sport", :description => "Because travel does not necessarily rhyme with relaxation.")
Tag.create!(:name => "Transport", :description => "Can be a road trip, a plane ride, etc.")

Locategory.delete_all
Locategory.create!(:name => "Big city", :description => "This is a big city for you!", :marker_size => "large", :marker_symbol => "town-hall", :marker_color => "#4A4459")
Locategory.create!(:name => "Small city", :description => "A less famous city.", :marker_size => "medium", :marker_symbol => "town-hall", :marker_color => "#887D75")
Locategory.create!(:name => "Point of interest", :description => "A castle, a national park or a beautiful landscape.", :marker_size => "medium", :marker_symbol => "star", :marker_color => "#7FA4B1")