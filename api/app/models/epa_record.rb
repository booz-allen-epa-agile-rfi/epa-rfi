class EpaRecord < ActiveRecord::Base
  # has_many :states, class_name: 'States', foreign_key: :state_code, primary_key: :state_code
  # has_many :counties, class_name: 'Counties', through: :states
  # has_many :geo_json, through: :counties

  # Scopes
  scope :states_list, -> { select('states.state_code, facility_state, state_name').joins(:states).distinct.map do |x|
      { state_code: x.state_code, state: x.facility_state, name: x.state_name }
    end
  }
  scope :chemicals, -> { select('chemical_name').distinct.as_json }

  scope :counties_list, -> { select('counties.county_code, facility_county').join(:counties).distinct.map do |x| {county: x.facility_county} end }

  scope :zip_codes, -> {
    select('facility_zip_code').distinct.where('LENGTH(facility_zip_code) IN (?)', [5, 9]).map do |x|
      {zip_code: x.facility_zip_code}
    end
  }

  scope :state_counties, -> (state) {
    select('facility_state, facility_county').where(facility_state: state).distinct.map do |x|
      {state: x.facility_state, county: x.facility_county}
    end
  }

  scope :county_totals, -> {
    subquery = select('facility_state, facility_county, COUNT(*), SUM(CASE WHEN total_air_emissions~E\'^\\\\d+$\' THEN total_air_emissions::float ELSE 0 END) AS total_air_emissions, SUM(CASE WHEN total_underground_injection~E\'^\\\\d+$\' THEN total_underground_injection::float ELSE 0 END) AS total_underground_injection, SUM(CASE WHEN total_on_site_land_releases~E\'^\\\\d+$\' THEN total_on_site_land_releases::float ELSE 0 END) AS total_on_site_land_releases, SUM(CASE WHEN total_surface_water_discharge~E\'^\\\\d+$\' THEN total_surface_water_discharge::float ELSE 0 END) AS total_surface_water_discharge').group('facility_state, facility_county')
    select('facility_state, facility_county, count, total_air_emissions, total_underground_injection, total_on_site_land_releases, total_surface_water_discharge, total_air_emissions + total_underground_injection + total_on_site_land_releases + total_surface_water_discharge AS total').from("(#{subquery.to_sql}) AS t1").map do |x|
      {state: x.facility_state, county: x.facility_county, count: x.count, total_air_emissions: x.total_air_emissions, total_underground_injection: x.total_underground_injection, total_on_site_land_releases: x.total_on_site_land_releases, total_surface_water_discharge: x.total_surface_water_discharge, total: x.total}
    end
  }
end