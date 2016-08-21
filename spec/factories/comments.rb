FactoryGirl.define do
  factory :comment do
    body "MyString"
    user
    commentable_type "Answer"
    commentable_id 1
  end
end
