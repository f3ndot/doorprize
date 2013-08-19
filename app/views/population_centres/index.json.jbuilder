json.array!(@population_centres) do |population_centre|
  json.extract! population_centre, :city, :province, :latitude, :longitude
  json.url population_centre_url(population_centre, format: :json)
end
