# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    question
  end

  factory :answer_with_choice, :parent => :answer do
    choice
    question { choice.question }
  end
end
