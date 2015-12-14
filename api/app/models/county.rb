class County < ActiveRecord::Base
  belongs_to :state
  has_many :geo_json
end