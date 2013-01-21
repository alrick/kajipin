class Accesstoken < ActiveRecord::Base
  attr_accessible :value, :user_id, :account

  belongs_to :user
  
  validates :token, :account, :type, :secret, :presence => true
  validates :user_id, :numericality => { :greater_than => 0 }
  validates :type, :uniqueness => { :scope => :user_id }

  # Func to know if a specific user has a specific token type
  def self.has_token_type(user, type)
    where(:user_id => user.id, :type => type).exists?
  end
end
