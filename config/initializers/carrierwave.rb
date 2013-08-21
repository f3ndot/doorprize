CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider           => 'Rackspace',
    :rackspace_username => ENV['RACKSPACE_USERNAME'],
    :rackspace_api_key  => ENV['RACKSPACE_API_KEY']
  }
  config.fog_directory = ENV['RACKSPACE_CONTAINER']
  config.asset_host = "http://c3cc0651ea0da33163e6-46f7da2349b90883c35250488b638a48.r84.cf1.rackcdn.com"
end
