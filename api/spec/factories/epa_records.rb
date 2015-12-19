FactoryGirl.define do
  factory :epa_record do
    facility_county 'TRAVIS'
    latitude 0
    longitude 0
    total_underground_injection 100
    total_on_site_land_releases 300
    total_air_emissions 200
  end
end
