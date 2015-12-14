class States < ActiveRecord::Base
  has_many :epa_records
  has_many :counties
  has_many :geo_json
end