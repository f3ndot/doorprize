json.array!(@cars) do |car|
  json.extract! car, :description, :make, :color, :license_plate, :damage, :incident_id,
  json.url car_url(car, format: :json)
end
