FactoryGirl.define do
  factory :vote do
    user
    votable_id 1
    votable_type "Question"
    up_flag false
  end
end
