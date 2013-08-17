require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test "display the prelaunch page if not launched and in production" do

    @controller = IncidentsController.new

    Rails.env = 'production'
    get :index
    assert_select 'body.prelaunch'

    ['development', 'staging', 'test'].each do |env|
      Rails.env = env
      get :index
      assert_select 'body.prelaunch', false
    end
  end

  test "should render development warning banner" do
    @controller = IncidentsController.new
    get :index
    assert_template layout: "layouts/application"
    assert_select 'div.dev-warning', false

    Rails.env = 'development'
    get :index
    assert_template layout: "layouts/application"
    assert_select 'div.dev-warning'
  end

end
