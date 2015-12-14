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

ActiveRecord::Schema.define(version: 20151210232050) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "counties", force: :cascade do |t|
    t.integer "county_code", null: false
    t.string  "county_name", null: false
    t.integer "state_id"
  end

  add_index "counties", ["county_code"], name: "index_counties_on_county_code", using: :btree
  add_index "counties", ["state_id", "county_code"], name: "index_counties_on_state_id_and_county_code", unique: true, using: :btree
  add_index "counties", ["state_id"], name: "index_counties_on_state_id", using: :btree

  create_table "epa_data", force: :cascade do |t|
    t.string "cas_number"
    t.string "reporting_year"
    t.string "trifid"
    t.string "facility_name"
    t.string "facility_city"
    t.string "facility_county"
    t.string "county_code"
    t.string "facility_state"
    t.string "state_code"
    t.string "facility_zip_code"
    t.string "primary_naics_code"
    t.string "latitude"
    t.string "longitude"
    t.string "geo_json_id"
    t.string "parent_company_name"
    t.string "chemical_name"
    t.string "classification"
    t.string "unit_of_measure"
    t.string "produce_the_chemical"
    t.string "import_the_chemical"
    t.string "on_site_use"
    t.string "sale_or_distribution"
    t.string "as_a_byproduct"
    t.string "as_a_manufactured_impurity"
    t.string "as_a_reactant"
    t.string "as_a_formulation_component"
    t.string "as_an_article_component"
    t.string "repackaging"
    t.string "as_a_process_impurity"
    t.string "as_a_chemical_processing_aid"
    t.string "as_a_manufacturing_aid"
    t.string "ancillary_or_other_use"
    t.string "total_air_emissions"
    t.string "total_underground_injection"
    t.string "total_on_site_land_releases"
    t.string "total_transferred_off_site_to_disposal"
    t.string "document_control_number"
    t.string "int8"
    t.string "total_surface_water_discharge"
    t.string "transfers_to_potws_metals_and_metal_compounds"
    t.string "naics_2"
    t.string "naics_3"
    t.string "chemical"
    t.string "cercla_chemicals"
    t.string "haps"
    t.string "metals_and_metal_compounds"
    t.string "pbt_chemicals"
    t.string "priority_chemicals"
    t.string "osha_chemicals"
    t.string "other_health_effects"
    t.string "body_weight"
    t.string "cardiovascular"
    t.string "dermal"
    t.string "developmental"
    t.string "endocrine"
    t.string "gastrointestinal"
    t.string "hematological"
    t.string "hepatic"
    t.string "immunological"
    t.string "metabolic"
    t.string "musculoskeletal"
    t.string "neurological"
    t.string "ocular"
    t.string "other_systemic"
    t.string "renal"
    t.string "reproductive"
    t.string "respiratory"
    t.string "human_health_effects_information_not_identified"
    t.string "acute"
    t.string "intermediate"
    t.string "chronic"
  end

  create_table "epa_records", force: :cascade do |t|
    t.string  "cas_number",                                      limit: 9
    t.integer "reporting_year"
    t.string  "trifid",                                          limit: 15
    t.string  "facility_name",                                   limit: 62
    t.string  "facility_city",                                   limit: 25
    t.string  "facility_county",                                 limit: 23
    t.integer "county_code"
    t.string  "facility_state",                                  limit: 2
    t.integer "facility_zip_code"
    t.string  "primary_naics_code",                              limit: 6
    t.decimal "latitude",                                                   precision: 9, scale: 6
    t.decimal "longitude",                                                  precision: 9, scale: 6
    t.string  "parent_company_name",                             limit: 60
    t.string  "chemical_name",                                   limit: 70
    t.string  "classification",                                  limit: 6
    t.string  "unit_of_measure",                                 limit: 6
    t.string  "produce_the_chemical",                            limit: 3
    t.string  "import_the_chemical",                             limit: 3
    t.string  "on_site_use",                                     limit: 3
    t.string  "sale_or_distribution",                            limit: 3
    t.string  "as_a_byproduct",                                  limit: 3
    t.string  "as_a_manufactured_impurity",                      limit: 3
    t.string  "as_a_reactant",                                   limit: 3
    t.string  "as_a_formulation_component",                      limit: 3
    t.string  "as_an_article_component",                         limit: 3
    t.string  "repackaging",                                     limit: 3
    t.string  "as_a_process_impurity",                           limit: 3
    t.string  "as_a_chemical_processing_aid",                    limit: 3
    t.string  "as_a_manufacturing_aid",                          limit: 3
    t.string  "ancillary_or_other_use",                          limit: 3
    t.integer "total_air_emissions"
    t.integer "total_underground_injection"
    t.integer "total_on_site_land_releases"
    t.integer "total_transferred_off_site_to_disposal"
    t.integer "document_control_number",                         limit: 8
    t.integer "int8",                                            limit: 8
    t.integer "total_surface_water_discharge"
    t.integer "total_pollutants"
    t.string  "transfers_to_potws_metals_and_metal_compounds",   limit: 10
    t.string  "naics_2",                                         limit: 2
    t.string  "naics_3",                                         limit: 3
    t.string  "chemical",                                        limit: 70
    t.string  "cercla_chemicals",                                limit: 3
    t.string  "haps",                                            limit: 3
    t.string  "metals_and_metal_compounds",                      limit: 3
    t.string  "pbt_chemicals",                                   limit: 3
    t.string  "priority_chemicals",                              limit: 3
    t.string  "osha_chemicals",                                  limit: 3
    t.string  "other_health_effects",                            limit: 3
    t.string  "body_weight",                                     limit: 3
    t.string  "cardiovascular",                                  limit: 3
    t.string  "dermal",                                          limit: 3
    t.string  "developmental",                                   limit: 3
    t.string  "endocrine",                                       limit: 3
    t.string  "gastrointestinal",                                limit: 3
    t.string  "hematological",                                   limit: 3
    t.string  "hepatic",                                         limit: 3
    t.string  "immunological",                                   limit: 3
    t.string  "metabolic",                                       limit: 3
    t.string  "musculoskeletal",                                 limit: 3
    t.string  "neurological",                                    limit: 3
    t.string  "ocular",                                          limit: 3
    t.string  "other_systemic",                                  limit: 3
    t.string  "renal",                                           limit: 3
    t.string  "reproductive",                                    limit: 3
    t.string  "respiratory",                                     limit: 3
    t.string  "human_health_effects_information_not_identified", limit: 3
    t.string  "acute",                                           limit: 3
    t.string  "intermediate",                                    limit: 3
    t.string  "chronic",                                         limit: 3
    t.integer "state_id"
    t.integer "county_id"
    t.integer "geo_json_id"
  end

  add_index "epa_records", ["chemical_name"], name: "index_epa_records_on_chemical_name", using: :btree
  add_index "epa_records", ["county_code"], name: "index_epa_records_on_county_code", using: :btree
  add_index "epa_records", ["county_id"], name: "index_epa_records_on_county_id", using: :btree
  add_index "epa_records", ["facility_city"], name: "index_epa_records_on_facility_city", using: :btree
  add_index "epa_records", ["facility_name"], name: "index_epa_records_on_facility_name", using: :btree
  add_index "epa_records", ["facility_zip_code"], name: "index_epa_records_on_facility_zip_code", using: :btree
  add_index "epa_records", ["geo_json_id"], name: "index_epa_records_on_geo_json_id", using: :btree
  add_index "epa_records", ["latitude", "longitude"], name: "index_epa_records_on_latitude_and_longitude", using: :btree
  add_index "epa_records", ["latitude"], name: "index_epa_records_on_latitude", using: :btree
  add_index "epa_records", ["longitude"], name: "index_epa_records_on_longitude", using: :btree
  add_index "epa_records", ["reporting_year"], name: "index_epa_records_on_reporting_year", using: :btree
  add_index "epa_records", ["state_id", "county_code"], name: "index_epa_records_on_state_id_and_county_code", using: :btree
  add_index "epa_records", ["state_id"], name: "index_epa_records_on_state_id", using: :btree

  create_table "geo_json", force: :cascade do |t|
    t.jsonb   "geo_object",  null: false
    t.integer "county_code"
    t.integer "state_id"
    t.integer "county_id"
  end

  add_index "geo_json", ["county_code"], name: "index_geo_json_on_county_code", using: :btree
  add_index "geo_json", ["county_id"], name: "index_geo_json_on_county_id", using: :btree
  add_index "geo_json", ["state_id", "county_code"], name: "index_geo_json_on_state_id_and_county_code", unique: true, using: :btree
  add_index "geo_json", ["state_id"], name: "index_geo_json_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string "state_name",             null: false
    t.string "abbreviation", limit: 2, null: false
  end

  create_table "temp_counties", force: :cascade do |t|
    t.integer "state_code",  null: false
    t.integer "county_code", null: false
    t.string  "county_name", null: false
    t.jsonb   "coordinates", null: false
  end

  add_index "temp_counties", ["county_code"], name: "index_temp_counties_on_county_code", using: :btree
  add_index "temp_counties", ["state_code"], name: "index_temp_counties_on_state_code", using: :btree

  add_foreign_key "counties", "states"
  add_foreign_key "epa_records", "counties"
  add_foreign_key "epa_records", "geo_json"
  add_foreign_key "epa_records", "states"
  add_foreign_key "geo_json", "counties"
  add_foreign_key "geo_json", "states"
end
