class State < ActiveRecord::Base
  belongs_to :epa_record, foreign_key: :state_id
  has_many :counties
end