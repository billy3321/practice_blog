# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_group do
    sequence(:name)  { |n| "Product Group #{n}" }
  end
end