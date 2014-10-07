FactoryGirl.define do
  factory :user do
    name     "billy3321"
    email    "billy3321@example.com"
    password "P@ssw0rd"
    password_confirmation "P@ssw0rd"
  end

  factory :category do
    name 'test_category1'
  end

  factory :article do |variable|
    title 'test'
    content 'blah blah blah'
    user
  end

  factory :commet do
    name commet_user
    content 'commet test!!'
    article
  end
end