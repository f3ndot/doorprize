json.array!(@incidents) do |incident|
  json.extract! incident, :description, :datetime_of_incident, :location, :latitude, :longitude, :severity, :id, :to_s
  json.url incident_url(incident, format: :json)
end
