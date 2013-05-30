# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :choice do
    title_uk Faker::Lorem.word
    title_ru Faker::Lorem.word
    title_en Faker::Lorem.word
    is_correct { rand(2) == 0 }
    question
  end
end
