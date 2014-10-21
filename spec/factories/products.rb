# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    product_group
    sequence(:name)  { |n| "Product #{n}" }
  end
end