# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title_uk Faker::Lorem.word
    title_ru Faker::Lorem.word
    title_en Faker::Lorem.word
    sequence :video_url do |n|
      "http://www.youtube.com/watch?v=#{n}"
    end
    sec 3
    hint_uk Faker::Lorem.word
    hint_ru Faker::Lorem.word
    hint_en Faker::Lorem.word
  end
end
