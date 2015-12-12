class GeoJson < ActiveRecord::Base
  belongs_to :county
  belongs_to :epa_record
end