# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    title Faker::Lorem.word
    sequence :video_url do |n|
      "http://www.youtube.com/watch?v=#{n}"
    end
    sec 3
    hint Faker::Lorem.word
    group
  end
end
