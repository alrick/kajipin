class Location < ActiveRecord::Base
  attr_accessible :title, :subtitle, :country_id, :user_id, :latitude, :longitude
  validates :title, :latitude, :longitude, :user_id, :country_id, :presence => true

  belongs_to :user
  belongs_to :country
  has_many :comments, dependent: :destroy
  has_one :logbook, dependent: :destroy
  has_many :galleries, dependent: :destroy

end
