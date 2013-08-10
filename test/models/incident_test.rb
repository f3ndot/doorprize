require 'test_helper'

class IncidentTest < ActiveSupport::TestCase
  test "severity score range" do
    incident_one = incidents(:one)
    incident_two = incidents(:two)
    min_range = 0
    max_range = 10

    assert incident_one.severity.between?(min_range, max_range)
    assert incident_two.severity.between?(min_range, max_range)

    incident_one.severity = -1
    incident_two.severity = 11

    refute incident_one.severity.between?(min_range, max_range)
    refute incident_two.severity.between?(min_range, max_range)
  end

  test "severity text output" do
    assert_equal "Little to no injury. Scuffs and scrapes", incidents(:one).severity_text
  end
end
