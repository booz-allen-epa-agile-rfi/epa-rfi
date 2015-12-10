Rails.application.routes.draw do

  get 'states', to: 'epa_records#states'
  get 'chemicals', to: 'epa_records#chemicals'
  get 'zip_codes', to: 'epa_records#zip_codes'

  # JUST WANT TO QUERY THIS DATA - DO NOT WANT TO APPLY OTHER CRUD TO IT
  resources :epa_records, except: [:new, :edit, :update, :destroy]

  # Documentation - TODO: FIX THIS
  apipie
end
