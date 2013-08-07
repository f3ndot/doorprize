json.array!(@incidents) do |incident|
  json.extract! incident, :description, :datetime_of_incident, :location, :injured, :police_report_number, :video
  json.url incident_url(incident, format: :json)
end
