class Logpage < ActiveRecord::Base
  attr_accessible :title, :content, :pin_id

  belongs_to :pin
  has_many :assignments, dependent: :destroy
  has_many :tags, through: :assignments

  validates :title, :length => { :in => 2..100 }
  validates :content, :length => { :minimum => 2 }
  validates :pin_id, :numericality => { :greater_than => 0}
end
