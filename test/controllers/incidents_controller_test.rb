require 'test_helper'

class IncidentsControllerTest < ActionController::TestCase
  setup do
    @incident = incidents(:one)
  end

  # Not sure where this should go. It only cares about application layout
  test "should render development warning banner" do
    get :index
    assert_template layout: "layouts/application"
    assert_select 'div.dev-warning', false

    Rails.env = 'development'
    get :index
    assert_template layout: "layouts/application"
    assert_select 'div.dev-warning'
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incidents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incident" do
    assert_difference('Incident.count') do
      post :create, incident: { datetime_of_incident: @incident.datetime_of_incident, description: @incident.description, injured: @incident.injured, location: @incident.location, police_report_number: @incident.police_report_number, video: @incident.video, severity: @incident.severity }
    end

    assert_redirected_to incident_path(assigns(:incident))
  end

  test "should show incident" do
    get :show, id: @incident
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @incident
    assert_response :success
  end

  test "should update incident" do
    patch :update, id: @incident, incident: { datetime_of_incident: @incident.datetime_of_incident, description: @incident.description, injured: @incident.injured, location: @incident.location, police_report_number: @incident.police_report_number, video: @incident.video }
    assert_redirected_to incident_path(assigns(:incident))
  end

  test "should destroy incident" do
    assert_difference('Incident.count', -1) do
      delete :destroy, id: @incident
    end

    assert_redirected_to incidents_path
  end
end
