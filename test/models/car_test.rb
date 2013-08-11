require 'test_helper'

class CarTest < ActiveSupport::TestCase
  test "at least one field is filled" do
    refute Car.new().valid?
    assert Car.new({description: 'A shitty van hit me'}).valid?
    assert cars(:volvo).valid?
    assert cars(:bmw).valid?
  end

  test "license plate always in uppercase" do
    cars = []
    cars.push Car.new({license_plate: "a1a1 a1a1"})
    cars.push Car.new({license_plate: "A1A1 A1A1"})

    cars.each do |c|
      assert_equal "A1A1 A1A1", c.license_plate
    end
  end
end
