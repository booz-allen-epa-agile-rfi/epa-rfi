class States < ActiveRecord::Base
  self.primary_key = :state_code
  # belongs_to :epa_record
  # has_many :counties
end