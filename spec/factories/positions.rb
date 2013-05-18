# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :position do
    alignment 'center'
    dx { rand(13) - 6 }
    dy { rand(6) + 1 }
    is_highlighted { rand(2) == 0 }
    question
    color 'red'
  end
end
