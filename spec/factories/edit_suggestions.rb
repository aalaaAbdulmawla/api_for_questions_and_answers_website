FactoryGirl.define do
  factory :edit_suggestion do
    title "Suggested title"
    body "Suggested body"
    accepted_flag false
    user
    question
  end
end
