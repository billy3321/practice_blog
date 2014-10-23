FactoryGirl.define do
  factory :article do
    sequence(:title)  { |n| "Article #{n}" }
    sequence(:content) { |n| "Article_#{n} Content"}
    user{ FactoryGirl.create(:user) }
    category{ FactoryGirl.create(:category) }
  end
end