class EpaRecord < ActiveRecord::Base
  # Scopes
  scope :states, -> { select('facility_state').distinct.map do |x| x.facility_state end }
  scope :chemicals, -> { select('chemical_name').distinct.map do |x| x.chemical_name end }
  scope :zip_codes, -> { select('facility_zip_code').distinct.map do |x| x.facility_zip_code end }
end
