FactoryGirl.define do
  factory :user do
  	email { FFaker::Internet.email }
  	password "12345678"
  	password_confirmation "12345678"
    first_name "MyString"
    last_name "MyString"
    birth_date "2016-08-01"
    location "MyString"
    job "MyString"
    about "MyText"
    experience 1
  end
end
