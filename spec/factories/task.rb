FactoryBot.define do
  factory :task do
    task_name { "Sample Task" }
    state { 0 }
    deadline_date { DateTime.now + 2.days }
    association :created_by, factory: :user
  end
end