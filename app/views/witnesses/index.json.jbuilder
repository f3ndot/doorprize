json.array!(@witnesses) do |witness|
  json.extract! witness, :privacy_level
  json.url witness_url(witness, format: :json)
end
