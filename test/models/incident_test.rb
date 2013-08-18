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

  test "severity color" do
    for i in 0..10
      assert_match /#[0-9a-f]{3}|[0-9a-f]{6}/, Incident.severity_color(i)
    end
  end

  test "incident datetime cant be in the future" do
    incident = incidents(:one)
    refute incident.datetime_of_incident.future?
    refute incident.datetime_of_incident.blank?
    assert incident.valid?

    incident.datetime_of_incident = DateTime.now + 1.day

    refute incident.valid?
  end

  test "incident description is not blank" do
    incident = incidents(:one)
    assert incident.valid?

    incident.description = ''
    refute incident.valid?
  end

  test "incident location is not blank" do
    incident = incidents(:one)
    assert incident.valid?

    incident.location = ''
    refute incident.valid?
  end
end
