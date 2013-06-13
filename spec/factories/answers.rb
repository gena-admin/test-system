# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    question
    answered_at { DateTime.now }
  end

  factory :answer_with_choice, :parent => :answer do
    choice
    question { choice.question }
  end

  factory :answer_with_correct_choice, :parent => :answer_with_choice do
    association :choice, :factory => :choice, :is_correct => true
  end

  factory :answer_with_incorrect_choice, :parent => :answer_with_choice do
    association :choice, :factory => :choice, :is_correct => false
  end
end
