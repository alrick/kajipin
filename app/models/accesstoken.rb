class Accesstoken < ActiveRecord::Base
  belongs_to :user
  
  validates :value, :presence => true
  validates :user_id, :numericality => { :greater_than => 0}
  validates :ilk, :inclusion => { :in => %w(twitter facebook dropbox) }
  validates :ilk, :uniqueness => {:scope => :user_id}

  scope :dropbox, where(ilk: Appetizer.dropbox_token)
  scope :twitter, where(ilk: Appetizer.twitter_token)
  scope :facebook, where(ilk: Appetizer.facebook_token)
end
