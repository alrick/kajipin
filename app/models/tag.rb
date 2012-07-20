class Tag < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :assignments, dependent: :destroy
  has_many :logpages, through: :assignments

  validates :name, :length => { :in => 2..20 }
  validates :description, :length => { :in => 2..100 }
end
