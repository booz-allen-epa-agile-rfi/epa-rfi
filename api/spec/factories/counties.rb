FactoryGirl.define do
  factory :county do
    sequence :county_name do |n|
      "State #{n}"
    end
    sequence :county_code do |n|
      "#{n}"
    end
  end
end
