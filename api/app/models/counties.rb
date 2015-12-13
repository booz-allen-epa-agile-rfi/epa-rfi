class Counties < ActiveRecord::Base
  self.primary_key = :county_code
  # belongs_to :states, class_name: 'States', foreign_key: :state_code
  # has_many :geo_json
end