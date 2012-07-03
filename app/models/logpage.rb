class Logpage < ActiveRecord::Base

  belongs_to :logbook
  has_many :assignments, dependent: :destroy
  has_many :tags, through: :assignments
  
end
