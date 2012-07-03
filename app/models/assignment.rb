class Assignment < ActiveRecord::Base
  
  belongs_to :logpage
  belongs_to :tag

end
