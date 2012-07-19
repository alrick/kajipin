require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "should not save location without title" do
    l = Location.new
    l.latitude = 46.69661
    l.longitude = 6.97624
    l.user_id = 2
    l.country_id = 171
    assert !l.save, "Saved the location without a title"
  end

  test "should not save location without latitude" do
    l = Location.new
    l.title = "Massonnens"
    l.longitude = 6.97624
    l.user_id = 2
    l.country_id = 171
    assert !l.save, "Saved the location without a latitude"
  end

  test "should not save location without longitude" do
    l = Location.new
    l.title = "Massonnens"
    l.latitude = 46.69661
    l.user_id = 2
    l.country_id = 171
    assert !l.save, "Saved the location without a longitude"
  end

  test "should not save location without user_id" do
    l = Location.new
    l.title = "Massonnens"
    l.latitude = 46.69661
    l.longitude = 6.97624
    l.country_id = 171
    assert !l.save, "Saved the location without a user_id"
  end

  test "should not save location without country_id" do
    l = Location.new
    l.title = "Massonnens"
    l.latitude = 46.69661
    l.longitude = 6.97624
    l.user_id = 2
    assert !l.save, "Saved the location without a country_id"
  end
end
