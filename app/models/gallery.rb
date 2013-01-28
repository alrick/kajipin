class Gallery < ActiveRecord::Base
  attr_accessible :pin_id, :accesstoken_id

  belongs_to :pin
  belongs_to :accesstoken

  validates :pin_id, :numericality => { :greater_than => 0}
  validates :accesstoken_id, :numericality => { :greater_than => 0}

  def full_path
    "Apps/Kajipin/" + pin.normalized+ "/"
  end

  def path
    pin.normalized
  end
end
