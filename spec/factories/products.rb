# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    product_group{ FactoryGirl.create(:product_group) }
    sequence(:name)  { |n| "Product #{n}" }
  end
end