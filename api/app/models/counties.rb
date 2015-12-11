class Counties < ActiveRecord::Base
  belongs_to :states
  has_many :epa_records
  has_many :geo_json
end