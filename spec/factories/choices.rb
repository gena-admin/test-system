# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :choice do
    title Faker::Lorem.word
    is_correct { rand(2) == 0 }
    question
  end
end
