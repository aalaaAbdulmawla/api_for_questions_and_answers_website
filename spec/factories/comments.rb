FactoryGirl.define do
  factory :comment do
    body "MyString"
    user_id 1
    commentable_type "any_model"
    commentable_id 1
  end
end
