FactoryGirl.define do
  factory :article do |variable|
    sequence(:title)  { |n| "Article #{n}" }
    sequence(:content) { |n| "Article_#{n} Content"}
    user
  end
end