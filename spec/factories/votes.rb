FactoryGirl.define do
  factory :vote do
    user_id 1
    votable_id 1
    votable_type "some_model"
    up_flag false
  end
end
