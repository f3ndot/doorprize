require 'test_helper'

class IncidentsControllerTest < ActionController::TestCase
  setup do
    @incident = incidents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incidents)
  end

  test "should sort index by newest incidents" do
    get :index, sort: 'latest'
    assert_response :success
    assert_not_nil assigns(:incidents)
    assert assigns(:incidents)[0].datetime_of_incident > assigns(:incidents)[1].datetime_of_incident, 'First result is not newer than second'
  end

  test "should sort index by oldest incidents" do
    get :index, sort: 'oldest'
    assert_response :success
    assert_not_nil assigns(:incidents)
    assert assigns(:incidents)[0].datetime_of_incident < assigns(:incidents)[1].datetime_of_incident, 'First result is not older than second'
  end

  test "should sort index by newest submission" do
    get :index, sort: 'latest-submitted'
    assert_response :success
    assert_not_nil assigns(:incidents)
    assert assigns(:incidents)[0].created_at > assigns(:incidents)[1].created_at, 'First result\'s submission date is not newer than second'
  end

  test "should sort index by oldest submission" do
    get :index, sort: 'oldest-submitted'
    assert_response :success
    assert_not_nil assigns(:incidents)
    assert assigns(:incidents)[0].created_at < assigns(:incidents)[1].created_at, 'First result\'s submission date is not older than second'
  end

  test "should sort index by most severe" do
    get :index, sort: 'most-severe'
    assert_response :success
    assert_not_nil assigns(:incidents)
    assert assigns(:incidents)[0].severity > assigns(:incidents)[1].severity, 'First result is not more severe than second'
  end

  test "should sort index by least severe" do
    get :index, sort: 'least-severe'
    assert_response :success
    assert_not_nil assigns(:incidents)
    assert assigns(:incidents)[0].severity < assigns(:incidents)[1].severity, 'First result is not less severe than second'
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incident" do
    assert_difference('Incident.count') do
      post :create, incident: { datetime_of_incident: @incident.datetime_of_incident, description: @incident.description, location: @incident.location, police_report_number: @incident.police_report_number, video: @incident.video, severity: @incident.severity }
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
    patch :update, id: @incident, incident: { datetime_of_incident: @incident.datetime_of_incident, description: @incident.description, location: @incident.location, police_report_number: @incident.police_report_number, video: @incident.video }
    assert_redirected_to incident_path(assigns(:incident))
  end

  test "should destroy incident" do
    assert_difference('Incident.count', -1) do
      delete :destroy, id: @incident
    end

    assert_redirected_to incidents_path
  end
end
