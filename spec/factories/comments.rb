FactoryGirl.define do
  factory :commet do
    sequence(:name)  { |n| "Commenter #{n}" }
    sequence(:email) { |n| "comment_#{n} content"}
    article
  end
end