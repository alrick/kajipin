class Gallery < ActiveRecord::Base
  attr_accessible :title, :pin_id, :normalized, :accesstoken_id

  belongs_to :pin
  belongs_to :accesstoken

  validates :title, :normalized, :presence => true
  validates :title, :length => { :maximum => 100 }
  validates :pin_id, :numericality => { :greater_than => 0}
  validates :accesstoken_id, :numericality => { :greater_than => 0}
  validates :normalized, :uniqueness => {:scope => :pin_id}

  def full_path
    "Apps/Kajipin/" + pin.normalized+ "/" + normalized.to_s + "/"
  end

  def dropbox_path
    pin.normalized+ "/" + normalized.to_s
  end
end
