class Herald < ActiveRecord::Base

  before_create :generate_key

  attr_accessible :key, :user_id

  belongs_to :user

  protected

  def generate_key
    self.key = loop do
      random_key = SecureRandom.urlsafe_base64(25)
      break random_key unless Herald.where(key: random_key).exists?
    end
  end
end
