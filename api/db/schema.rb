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

ActiveRecord::Schema.define(version: 20151209162932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "epa_records", force: :cascade do |t|
    t.integer "old_id"
    t.string  "cas_number",                                      limit: 9
    t.integer "reporting_year"
    t.string  "trifid",                                          limit: 15
    t.string  "facility_name",                                   limit: 62
    t.string  "facility_city",                                   limit: 25
    t.string  "facility_county",                                 limit: 23
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
    t.integer "total_surface_water_discharge"
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
  end

  add_index "epa_records", ["chemical_name"], name: "index_epa_records_on_chemical_name", using: :btree
  add_index "epa_records", ["facility_city"], name: "index_epa_records_on_facility_city", using: :btree
  add_index "epa_records", ["facility_name"], name: "index_epa_records_on_facility_name", using: :btree
  add_index "epa_records", ["facility_zip_code"], name: "index_epa_records_on_facility_zip_code", using: :btree
  add_index "epa_records", ["latitude", "longitude"], name: "index_epa_records_on_latitude_and_longitude", using: :btree
  add_index "epa_records", ["latitude"], name: "index_epa_records_on_latitude", using: :btree
  add_index "epa_records", ["longitude"], name: "index_epa_records_on_longitude", using: :btree
  add_index "epa_records", ["reporting_year"], name: "index_epa_records_on_reporting_year", using: :btree
  add_index "epa_records", ["total_air_emissions"], name: "index_epa_records_on_total_air_emissions", using: :btree
  add_index "epa_records", ["total_on_site_land_releases"], name: "index_epa_records_on_total_on_site_land_releases", using: :btree
  add_index "epa_records", ["total_surface_water_discharge"], name: "index_epa_records_on_total_surface_water_discharge", using: :btree
  add_index "epa_records", ["total_transferred_off_site_to_disposal"], name: "index_epa_records_on_total_transferred_off_site_to_disposal", using: :btree
  add_index "epa_records", ["total_underground_injection"], name: "index_epa_records_on_total_underground_injection", using: :btree

end
