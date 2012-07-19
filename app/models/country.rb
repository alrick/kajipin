class Country < ActiveRecord::Base
  attr_accessible :name, :continent_id
  
  belongs_to :continent
  has_many :locations

end
