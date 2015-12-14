class States < ActiveRecord::Base
  # self.primary_key = :state_code
  belongs_to :epa_record, foreign_key: :state_id
  has_many :counties, foreign_key: :county_code
end