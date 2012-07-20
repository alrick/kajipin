class Assignment < ActiveRecord::Base
  belongs_to :logpage
  belongs_to :tag
  
  validates :logpage_id, :tag_id, :numericality => { :greater_than => 0}
end
