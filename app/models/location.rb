class Location < ActiveRecord::Base

  belongs_to :user
  belongs_to :country
  has_many :comments, dependent: :destroy
  has_one :logbook, dependent: :destroy
  has_many :galleries, dependent: :destroy

end
