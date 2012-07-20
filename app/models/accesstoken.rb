class Accesstoken < ActiveRecord::Base
  belongs_to :user
  
  validates :value, :presence => true
  validates :user_id, :numericality => { :greater_than => 0}
  validates :type, :inclusion => { :in => %w(twitter facebook flickr dropbox) }
end
