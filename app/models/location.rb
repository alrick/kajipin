class Location < ActiveRecord::Base
  attr_accessible :title, :subtitle, :user_id, :latitude, :longitude

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :logbook, dependent: :destroy
  has_many :galleries, dependent: :destroy

  validates :title, :country_name, :continent_name, :presence => true
  validates :latitude, :longitude, :numericality => true
  validates :subtitle, :length => { :in => 2..100 }, :allow_blank => true
  validates :user_id, :numericality => { :greater_than => 0}
end
