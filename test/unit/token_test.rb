require 'test_helper'

class TokenTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Token.new.valid?
  end
end
