FactoryGirl.define do
  factory :goal do
    content { Faker::Hacker.say_something_smart }
    private { [true, false].sample }
    completed { false }
    association :goal_setter, factory: :user
    factory :public_goal do
      private { false }
    end

  end
end
