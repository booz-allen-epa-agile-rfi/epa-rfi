class GeoJson < ActiveRecord::Base
  has_many :epa_records
  belongs_to :states
  belongs_to :counties
end