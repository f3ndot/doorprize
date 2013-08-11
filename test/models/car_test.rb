require 'test_helper'

class CarTest < ActiveSupport::TestCase
  test "description presence" do
    assert_not_equal "", cars(:volvo).description
    assert_not_nil cars(:volvo).description
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
