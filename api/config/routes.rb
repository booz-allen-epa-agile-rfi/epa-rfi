Rails.application.routes.draw do

  get 'states', to: 'epa_records#states_list'
  get 'chemicals', to: 'epa_records#chemicals'
  get 'zip_codes', to: 'epa_records#zip_codes'
  get 'counties', to: 'epa_records#counties_list'
  get 'county_totals', to: 'epa_records#county_totals'
  get 'state_counties/:state', to: 'epa_records#state_counties'
  post 'search', to: 'epa_records#search'

  # JUST WANT TO QUERY THIS DATA - DO NOT WANT TO APPLY OTHER CRUD TO IT
  # resources :epa_records, except: [:new, :edit, :update, :destroy]

  # Documentation - TODO: FIX THIS
  apipie

  root 'epa_records#index'
end
