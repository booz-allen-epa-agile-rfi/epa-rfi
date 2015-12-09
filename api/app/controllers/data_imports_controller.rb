class DataImportsController < ApplicationController
  before_action :set_data_import, only: [:show, :update, :destroy]

  # GET /data_imports
  # GET /data_imports.json
  def index
    @data_imports = DataImport.all

    render json: @data_imports
  end

  # GET /data_imports/1
  # GET /data_imports/1.json
  def show
    render json: @data_import
  end

  # POST /data_imports
  # POST /data_imports.json
  def create
    @data_import = DataImport.new(data_import_params)

    if @data_import.save
      render json: @data_import, status: :created, location: @data_import
    else
      render json: @data_import.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /data_imports/1
  # PATCH/PUT /data_imports/1.json
  def update
    @data_import = DataImport.find(params[:id])

    if @data_import.update(data_import_params)
      head :no_content
    else
      render json: @data_import.errors, status: :unprocessable_entity
    end
  end

  # DELETE /data_imports/1
  # DELETE /data_imports/1.json
  def destroy
    @data_import.destroy

    head :no_content
  end

  private

    def set_data_import
      @data_import = DataImport.find(params[:id])
    end

    def data_import_params
      params.require(:data_import).permit(:cas_number, :reporting_year, :trifid, :facility_name, :facility_city, :facility_county, :facility_state, :facility_zip_code, :primary_naics_code, :latitude, :longitude, :parent_company_name, :chemical_name, :classification, :unit_of_measure, :produce_the_chemical, :import_the_chemical, :on_site_use, :sale_or_distribution, :as_a_byproduct, :as_a_manufactured_impurity, :as_a_reactant, :as_a_formulation_component, :as_an_article_component, :repackaging, :as_a_process_impurity, :as_a_chemical_processing_aid, :as_a_manufacturing_aid, :ancillary_or_other_use, :total_air_emissions, :total_underground_injection, :total_on_site_land_releases, :total_transferred_off_site_to_disposal, :document_control_number, :total_surface_water_discharge, :transfers_to_potws_metals_and_metal_compounds, :naics_2, :naics_3, :chemical, :cercla_chemicals, :haps, :metals_and_metal_compounds, :pbt_chemicals, :priority_chemicals, :osha_chemicals, :other_health_effects, :body_weight, :cardiovascular, :dermal, :developmental, :endocrine, :gastrointestinal, :hematological, :hepatic, :immunological, :metabolic, :musculoskeletal, :neurological, :ocular, :other_systemic, :renal, :reproductive, :respiratory, :human_health_effects_information_not_identified, :acute, :intermediate, :chronic)
    end
end
