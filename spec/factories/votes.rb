FactoryGirl.define do
  factory :vote do
    user_id 1
    votable_id 1
    votable_type 1
    up_flag false
  end
end
