json.array!(@cars) do |car|
  json.extract! car, :description, :make, :color, :license_plate, :damage, :incident_id, :driver_name, :driver_contact
  json.url car_url(car, format: :json)
end
