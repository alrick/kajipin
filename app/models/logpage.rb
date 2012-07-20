class Logpage < ActiveRecord::Base
  belongs_to :logbook
  has_many :assignments, dependent: :destroy
  has_many :tags, through: :assignments

  validates :title, :length => { :in => 2..100 }
  validates :content, :length => { :minimum => 2 }
  validates :logbook_id, :numericality => { :greater_than => 0}
end
