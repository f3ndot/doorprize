require 'test_helper'

class WitnessesControllerTest < ActionController::TestCase
  setup do
    @witness = witnesses(:alice)
    @witness.incident = incidents(:one)
    @witness.incident.user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:witnesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create witness" do
    assert_difference('Witness.count') do
      post :create, witness: { contact: @witness.contact, name: @witness.name, privacy_level: @witness.privacy_level, incident_id: @witness.incident_id }
    end

    assert_redirected_to witness_path(assigns(:witness))
  end

  test "should show witness" do
    get :show, id: @witness
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @witness
    assert_response :success
  end

  test "should update witness" do
    patch :update, id: @witness, witness: { contact: @witness.contact, name: @witness.name, privacy_level: @witness.privacy_level, incident_id: @witness.incident_id }
    assert_redirected_to witness_path(assigns(:witness))
  end

  test "should destroy witness" do
    assert_difference('Witness.count', -1) do
      delete :destroy, id: @witness
    end

    assert_redirected_to witnesses_path
  end
end
