FactoryGirl.define do
 factory :photo do
   image File.open(File.join(Rails.root, '/spec/fixtures/files/test.jpg'))
   sequence(:title)  { |n| "Photo #{n}" }
   sequence(:description) { |n| "Photo_#{n} Description"}
   user { FactoryGirl.create(:user) }
 end
end