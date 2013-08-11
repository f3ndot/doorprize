require 'test_helper'

class CarsControllerTest < ActionController::TestCase
  setup do
    @car = cars(:volvo)
    @car.incident = incidents(:one)
  end

  # Commented out until I figure out how to load fixture associations
  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:cars)
  # end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create car" do
    assert_difference('Car.count') do
      post :create, car: { color: @car.color, damage: @car.damage, description: @car.description, driver_contact: @car.driver_contact, driver_name: @car.driver_name, incident_id: @car.incident_id, license_plate: @car.license_plate, make: @car.make }
    end

    assert_redirected_to car_path(assigns(:car))
  end

  test "should show car" do
    get :show, id: @car
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @car
    assert_response :success
  end

  test "should update car" do
    patch :update, id: @car, car: { color: @car.color, damage: @car.damage, description: @car.description, driver_contact: @car.driver_contact, driver_name: @car.driver_name, incident_id: @car.incident_id, license_plate: @car.license_plate, make: @car.make }
    assert_redirected_to car_path(assigns(:car))
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete :destroy, id: @car
    end

    assert_redirected_to cars_path
  end
end
