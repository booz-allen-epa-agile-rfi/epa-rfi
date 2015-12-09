require "rails_helper"

RSpec.describe DataImportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/data_imports").to route_to("data_imports#index")
    end

    it "routes to #new" do
      expect(:get => "/data_imports/new").to route_to("data_imports#new")
    end

    it "routes to #show" do
      expect(:get => "/data_imports/1").to route_to("data_imports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/data_imports/1/edit").to route_to("data_imports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/data_imports").to route_to("data_imports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/data_imports/1").to route_to("data_imports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/data_imports/1").to route_to("data_imports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/data_imports/1").to route_to("data_imports#destroy", :id => "1")
    end

  end
end
