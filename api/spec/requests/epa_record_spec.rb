require 'rails_helper'

RSpec.describe 'EPA RFI API', type: :request do
  let(:default_params) { { format: :json } }
  let(:epa_record) { create :epa_record }

  describe 'POST' do
    it 'searches epa_records by facility_county' do
      headers = { 'ACCEPT': 'application/json' }
      epa_record = EpaRecord.create id: 1, facility_county: 'TRAVIS'
      geoJSON = {type: "FeatureCollection", features: []}
      coords = [epa_record.longitude.to_f || 0, epa_record.latitude.to_f || 0]
      geoJSON[:features] << {type: "Feature", properties: epa_record, geometry: {
          type: 'Point',
          coordinates: coords
      }}
      post '/search', { facility_county: 'Travis' }, headers

      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(geoJSON.to_json)
    end

    it 'recieves a 404 if no record is found' do
      headers = { 'ACCEPT': 'application/json' }
      post '/search', { facility_county: 'Middle of Nowhere' }, headers

      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(404)
    end

    it 'searches epa_records for emissions pollutants' do
      headers = { 'ACCEPT': 'application/json' }
      epa_record = EpaRecord.create id: 1, total_underground_injection: 100, total_on_site_land_releases: 300, total_air_emissions: 200
      geoJSON = {type: "FeatureCollection", features: []}
      coords = [epa_record.longitude.to_f || 0, epa_record.latitude.to_f || 0]
      geoJSON[:features] << {type: "Feature", properties: epa_record, geometry: {
          type: 'Point',
          coordinates: coords
      }}
      post '/search', { emissions: ['land', 'air'] }, headers

      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(geoJSON.to_json)
    end
  end
end
