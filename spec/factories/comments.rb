FactoryGirl.define do
  factory :comment do
    body "MyString"
    user
    commentable_type "any_model"
    commentable_id 1
  end
end
