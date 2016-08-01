FactoryGirl.define do
  factory :answer do
    body "MyText"
    user_id 1
    question_id 1
    accepted_flag false
  end
end
