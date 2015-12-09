# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151209162931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

<<<<<<< Updated upstream
  create_table "data_imports", force: :cascade do |t|
    t.string   "old_id"
=======
  create_table "epa_data", force: :cascade do |t|
>>>>>>> Stashed changes
    t.string   "cas_number"
    t.string   "reporting_year"
    t.string   "trifid"
    t.string   "facility_name"
    t.string   "facility_city"
    t.string   "facility_county"
    t.string   "facility_state"
    t.string   "facility_zip_code"
    t.string   "primary_naics_code"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "parent_company_name"
    t.string   "chemical_name"
    t.string   "classification"
    t.string   "unit_of_measure"
    t.string   "produce_the_chemical"
    t.string   "import_the_chemical"
    t.string   "on_site_use"
    t.string   "sale_or_distribution"
    t.string   "as_a_byproduct"
    t.string   "as_a_manufactured_impurity"
    t.string   "as_a_reactant"
    t.string   "as_a_formulation_component"
    t.string   "as_an_article_component"
    t.string   "repackaging"
    t.string   "as_a_process_impurity"
    t.string   "as_a_chemical_processing_aid"
    t.string   "as_a_manufacturing_aid"
    t.string   "ancillary_or_other_use"
    t.string   "total_air_emissions"
    t.string   "total_underground_injection"
    t.string   "total_on_site_land_releases"
    t.string   "total_transferred_off_site_to_disposal"
    t.string   "document_control_number"
    t.string   "total_surface_water_discharge"
    t.string   "transfers_to_potws_metals_and_metal_compounds"
    t.string   "naics_2"
    t.string   "naics_3"
    t.string   "chemical"
    t.string   "cercla_chemicals"
    t.string   "haps"
    t.string   "metals_and_metal_compounds"
    t.string   "pbt_chemicals"
    t.string   "priority_chemicals"
    t.string   "osha_chemicals"
    t.string   "other_health_effects"
    t.string   "body_weight"
    t.string   "cardiovascular"
    t.string   "dermal"
    t.string   "developmental"
    t.string   "endocrine"
    t.string   "gastrointestinal"
    t.string   "hematological"
    t.string   "hepatic"
    t.string   "immunological"
    t.string   "metabolic"
    t.string   "musculoskeletal"
    t.string   "neurological"
    t.string   "ocular"
    t.string   "other_systemic"
    t.string   "renal"
    t.string   "reproductive"
    t.string   "respiratory"
    t.string   "human_health_effects_information_not_identified"
    t.string   "acute"
    t.string   "intermediate"
    t.string   "chronic"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

end
