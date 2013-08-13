json.array!(@witnesses) do |witness|
  json.extract! witness, :name, :contact, :privacy_level
  json.url witness_url(witness, format: :json)
end
