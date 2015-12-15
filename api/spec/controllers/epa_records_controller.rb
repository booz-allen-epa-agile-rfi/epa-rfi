require 'rails_helper'

describe EpaRecordsController do
  let(:default_params) { { format: :json } }

  describe 'search by facility_county', type: :controller do
    it "returns a JSON error object if the county is not found" do
      post :search, facility_county: 'Middle of Nowhere'

      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status('404')
    end
  end
end
