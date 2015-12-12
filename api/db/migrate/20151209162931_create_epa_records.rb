class CreateEpaRecords < ActiveRecord::Migration
  def change
    create_table :epa_records do |t|
      t.string :cas_number
      t.string :reporting_year, index: true
      t.string :trifid
      t.string :facility_name, index: true
      t.string :facility_city, index: true
      t.string :facility_county
      t.integer :county_num_code, index: true
      t.string :facility_state
      t.integer :state_num_code, index: true
      t.string :facility_zip_code, index: true
      t.string :primary_naics_code
      t.string :latitude, index: true
      t.string :longitude, index: true
      t.references :geo_json, index: true
      t.string :parent_company_name
      t.string :chemical_name, index: true
      t.string :classification
      t.string :unit_of_measure
      # YES OR NO QUESTIONS
      t.string :produce_the_chemical, :limit => 3
      t.string :import_the_chemical, :limit => 3
      t.string :on_site_use, :limit => 3
      t.string :sale_or_distribution, :limit => 3
      t.string :as_a_byproduct, :limit => 3
      t.string :as_a_manufactured_impurity, :limit => 3
      t.string :as_a_reactant, :limit => 3
      t.string :as_a_formulation_component, :limit => 3
      t.string :as_an_article_component, :limit => 3
      t.string :repackaging, :limit => 3
      t.string :as_a_process_impurity, :limit => 3
      t.string :as_a_chemical_processing_aid, :limit => 3
      t.string :as_a_manufacturing_aid, :limit => 3
      t.string :ancillary_or_other_use, :limit => 3
      # COUNTS OF STUFF
      t.string :total_air_emissions
      t.string :total_underground_injection
      t.string :total_on_site_land_releases
      t.string :total_transferred_off_site_to_disposal
      t.string :document_control_number
      t.string :total_surface_water_discharge
      t.string :transfers_to_potws_metals_and_metal_compounds
      t.string :naics_2
      t.string :naics_3
      t.string :chemical
      # YES OR NO QUESTIONS
      t.string :cercla_chemicals, :limit => 3
      t.string :haps, :limit => 3
      t.string :metals_and_metal_compounds, :limit => 3
      t.string :pbt_chemicals, :limit => 3
      t.string :priority_chemicals, :limit => 3
      t.string :osha_chemicals, :limit => 3
      t.string :other_health_effects, :limit => 3
      t.string :body_weight, :limit => 3
      t.string :cardiovascular, :limit => 3
      t.string :dermal, :limit => 3
      t.string :developmental, :limit => 3
      t.string :endocrine, :limit => 3
      t.string :gastrointestinal, :limit => 3
      t.string :hematological, :limit => 3
      t.string :hepatic, :limit => 3
      t.string :immunological, :limit => 3
      t.string :metabolic, :limit => 3
      t.string :musculoskeletal, :limit => 3
      t.string :neurological, :limit => 3
      t.string :ocular, :limit => 3
      t.string :other_systemic, :limit => 3
      t.string :renal, :limit => 3
      t.string :reproductive, :limit => 3
      t.string :respiratory, :limit => 3
      t.string :human_health_effects_information_not_identified, :limit => 3
      t.string :acute, :limit => 3
      t.string :intermediate, :limit => 3
      t.string :chronic, :limit => 3
    end

    add_index :epa_records, [:county_num_code, :state_num_code], unique: true
    add_index :epa_records, [:latitude, :longitude], unique: true
  end
end
