FactoryGirl.define do
  factory :answer do
    body "MyText"
    user
    question
    accepted_flag false
  end
end
