require 'rails_helper'

RSpec.describe 'EPA RFI API', type: :request do
  let(:default_params) { { format: :json } }
  # let!(:epa_record) { create(:epa_record) }
  # let!(:post) { build_stubbed(:epa_record) }

  describe 'POST' do
    before(:each) do
      epa_record = create(:epa_record)
      epa_record = epa_record.attributes

      columns = ['old_id', 'cas_number', 'trifid', 'facility_city', 'facility_zip_code', 'primary_naics_code', 'classification', 'unit_of_measure', 'produce_the_chemical', 'import_the_chemical', 'on_site_use', 'sale_or_distribution', 'as_a_byproduct', 'as_a_manufactured_impurity', 'as_a_reactant', 'as_a_formulation_component', 'as_an_article_component', 'repackaging', 'as_a_process_impurity', 'as_a_chemical_processing_aid', 'as_a_manufacturing_aid', 'ancillary_or_other_use', 'total_transferred_off_site_to_disposal', 'document_control_number', 'transfers_to_potws_metals_and_metal_compounds', 'naics_2', 'naics_3', 'chemical', 'metals_and_metal_compounds', 'pbt_chemicals', 'other_health_effects', 'respiratory', 'human_health_effects_information_not_identified', 'acute', 'intermediate', 'chronic']
      columns.each { |k|
        epa_record.delete(k)
      }

      epa_record['id'] = nil

      coords = [epa_record[:longitude].to_f, epa_record[:latitude].to_f]
      @geoJSON = {
        type: "FeatureCollection",
        features: [
          {
            type: "Feature",
            properties: epa_record,
            geometry: {
              type: 'Point',
              coordinates: coords
            }
          }
        ]
      }
    end
    it 'searches epa_records by facility_county' do
      headers = { 'ACCEPT': 'application/json' }
      post '/search', { facility_county: 'TRAVIS' }, headers

      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(@geoJSON.to_json)
    end

    it 'recieves a 404 if no record is found' do
      headers = { 'ACCEPT': 'application/json' }
      post '/search', { facility_county: 'Middle of Nowhere' }, headers

      expect(response.content_type).to eq('application/json')
      expect(response.status).to eq(404)
    end

    it 'searches epa_records for emissions pollutants' do
      headers = { 'ACCEPT': 'application/json' }
      post '/search', { emissions: ['land', 'air'] }, headers

      expect(response.content_type).to eq('application/json')
      expect(response.body).to eq(@geoJSON.to_json)
    end
  end
end
