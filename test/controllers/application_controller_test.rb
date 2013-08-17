require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test "display the prelaunch page if not launched and in production" do

    @controller = IncidentsController.new

    [Time.new(2013, 8, 20, 23, 59, 59, '-04:00'), Time.new(2013, 8, 20, 0, 0, 0, '-04:00')].each do |time|
      Time.stubs(:now).returns time

      Rails.env = 'production'
      get :index
      assert_select 'body.prelaunch'
    end

    [Time.new(2013, 8, 21, 0, 0, 0, '-04:00'), Time.new(2013, 8, 22, 0, 0, 0, '-04:00')].each do |time|
      Time.stubs(:now).returns time

      Rails.env = 'production'
      get :index
      assert_select 'body.prelaunch', false
    end


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
