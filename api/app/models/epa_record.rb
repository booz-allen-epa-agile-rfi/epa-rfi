class EpaRecord < ActiveRecord::Base
  # Scopes
  scope :states, -> { select('facility_state').distinct.map { |x| { facility_state: x.facility_state } } }

  scope :chemicals, -> { select('chemical_name').distinct.map { |x| { chemical_name: x.chemical_name } } }

  scope :counties, -> { select('facility_county').distinct.map { |x| { facility_county: x.facility_county } } }

  scope :zip_codes, lambda {
    select('facility_zip_code, facility_county, facility_state').distinct
      .where('LENGTH(facility_zip_code::text) IN (?)', [5, 9]).map do |x|
      { facility_zip_code: x.facility_zip_code, facility_county: x.facility_county, facility_state: x.facility_state }
    end
  }

  scope :state_counties, lambda { |state|
    select('facility_state, facility_county').where(facility_state: state).distinct.map do |x|
      { state: x.facility_state, county: x.facility_county }
    end
  }

  scope :county_totals, lambda {
    subquery = select('facility_state, facility_county, COUNT(*), SUM(total_air_emissions) AS total_air_emissions,
                       SUM(total_underground_injection) AS total_underground_injection,
                       SUM(total_on_site_land_releases) AS total_on_site_land_releases,
                       SUM(total_surface_water_discharge) AS total_surface_water_discharge')
               .group('facility_state, facility_county')
    select('facility_state, facility_county, count, total_air_emissions, total_underground_injection,
            total_on_site_land_releases, total_surface_water_discharge,
            (total_underground_injection + total_on_site_land_releases + total_surface_water_discharge + total_air_emissions) AS total_pollutants')
      .from("(#{subquery.to_sql}) AS t1").map do |x|
      {
        state: x.facility_state, county: x.facility_county, count: x.count, total_air_emissions: x.total_air_emissions,
        total_underground_injection: x.total_underground_injection,
        total_on_site_land_releases: x.total_on_site_land_releases,
        total_surface_water_discharge: x.total_surface_water_discharge, total_pollutants: x.total_pollutants
      }
    end
  }

  scope :search, lambda {
    select('latitude, longitude, chemical_name, facility_name, parent_company_name, reporting_year, facility_state,
            facility_county, total_air_emissions, total_on_site_land_releases, total_underground_injection,
            total_surface_water_discharge, body_weight, cardiovascular, dermal, developmental, endocrine,
            gastrointestinal, hematological, hepatic, immunological, metabolic, musculoskeletal, neurological, ocular,
            other_systemic, renal, reproductive')
  }

  scope :emissions, ->(emissions) { where(emissions.join(' OR ')) unless emissions.nil? }

  scope :bounds, ->(bounds) { where(bounds.join(' AND ')) unless bounds.nil? }

  scope :years, lambda {
    select('reporting_year').distinct.order(:reporting_year).map { |x| { reporting_year: x.reporting_year } }
  }
end
