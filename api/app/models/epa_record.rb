class EpaRecord < ActiveRecord::Base
  # Scopes
  scope :states, -> { select('facility_state').distinct.map do |x| x.facility_state end }
  scope :chemicals, -> { select('chemical_name').distinct.map do |x| x.chemical_name end }
  scope :counties, -> { select('facility_county').distinct.map do |x| x.facility_county end }

  scope :zip_codes, -> {
    select('facility_zip_code').distinct.where('LENGTH(facility_zip_code) IN (?)', [5, 9]).map do |x|
      x.facility_zip_code
    end
  }

  scope :state_counties, -> (state) {
    select('facility_county').where(facility_state: state).distinct.map do |x|
      x.facility_county
    end
  }

  scope :county_totals, -> {
    subquery = select('facility_state, facility_county, COUNT(*), SUM(CASE WHEN total_air_emissions~E\'^\\\\d+$\' THEN total_air_emissions::float ELSE 0 END) AS total_air, SUM(CASE WHEN total_underground_injection~E\'^\\\\d+$\' THEN total_underground_injection::float ELSE 0 END) AS total_underground, SUM(CASE WHEN total_on_site_land_releases~E\'^\\\\d+$\' THEN total_on_site_land_releases::float ELSE 0 END) AS total_land, SUM(CASE WHEN total_surface_water_discharge~E\'^\\\\d+$\' THEN total_surface_water_discharge::float ELSE 0 END) AS total_water').group('facility_state, facility_county')
    select('facility_state, facility_county, count, total_air, total_underground, total_land, total_water, total_air + total_underground + total_land + total_water AS total').from("(#{subquery.to_sql}) AS t1").map do |x|
      {state: x.facility_state, county: x.facility_county, count: x.count, total_air: x.total_air, total_underground: x.total_underground, total_land: x.total_land, total_water: x.total_water, total: x.total}
    end
  }
end