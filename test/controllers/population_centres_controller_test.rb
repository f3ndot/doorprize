require 'test_helper'

class PopulationCentresControllerTest < ActionController::TestCase
  setup do
    @population_centre = population_centres(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:population_centres)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create population_centre" do
    assert_difference('PopulationCentre.count') do
      post :create, population_centre: { city: @population_centre.city, latitude: @population_centre.latitude, longitude: @population_centre.longitude, province: @population_centre.province }
    end

    assert_redirected_to population_centre_path(assigns(:population_centre))
  end

  test "should show population_centre" do
    get :show, id: @population_centre
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @population_centre
    assert_response :success
  end

  test "should update population_centre" do
    patch :update, id: @population_centre, population_centre: { city: @population_centre.city, latitude: @population_centre.latitude, longitude: @population_centre.longitude, province: @population_centre.province }
    assert_redirected_to population_centre_path(assigns(:population_centre))
  end

  test "should destroy population_centre" do
    assert_difference('PopulationCentre.count', -1) do
      delete :destroy, id: @population_centre
    end

    assert_redirected_to population_centres_path
  end
end
