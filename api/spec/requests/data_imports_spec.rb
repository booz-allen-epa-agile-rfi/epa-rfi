require 'rails_helper'

RSpec.describe "DataImports", type: :request do
  describe "GET /data_imports" do
    it "works! (now write some real specs)" do
      get data_imports_path
      expect(response).to have_http_status(200)
    end
  end
end
