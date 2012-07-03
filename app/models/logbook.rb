class Logbook < ActiveRecord::Base
  
  belongs_to :location
  has_many :logpages, dependent: :destroy
  
end
