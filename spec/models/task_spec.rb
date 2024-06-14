# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with valid attributes" do
    user = create(:user)
    task = Task.new(
      task_name: "Sample Task",
      state: :backlog,  # using enum value symbol
      deadline_date: DateTime.now + 2.days,
      created_by: user  # assigning the user who created the task
    )
    expect(task).to be_valid
  end

  it "is not valid without a task_name" do
    task = Task.new(state: 0, deadline_date: DateTime.now + 2.days)
    expect(task).not_to be_valid
  end

  it "is not valid without a state" do
    task = Task.new(task_name: "Sample Task", deadline_date: DateTime.now + 2.days)
    expect(task).not_to be_valid
  end

  it "is not valid without a deadline_date" do
    task = Task.new(task_name: "Sample Task", state: 0)
    expect(task).not_to be_valid
  end
end
