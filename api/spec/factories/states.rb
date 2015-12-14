FactoryGirl.define do
  factory :state do
    sequence :state_name do |n|
      "State #{n}"
    end
    sequence :abbreviation do |n|
      "#{n}"
    end
  end
end
