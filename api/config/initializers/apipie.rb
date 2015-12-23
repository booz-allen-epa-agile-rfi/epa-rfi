Apipie.configure do |config|
  config.app_name                = 'EpaRfi'
  config.api_base_url            = ''
  config.doc_base_url            = '/documentation'
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/*.rb"
  config.reload_controllers = true
end
