# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :report do
    student_id 1
    homework_id 1
    ratio 1.5
    quality 1.5
    time 1.5
  end
end
