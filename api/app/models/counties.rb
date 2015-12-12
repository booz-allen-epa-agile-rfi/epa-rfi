class Counties < ActiveRecord::Base
  belongs_to :state, foreign_key: :county_num_code
  has_many :geo_json
end