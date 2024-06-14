# spec/requests/tasks_spec.rb
require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }

  before do
    sign_in user
  end

  describe "GET /tasks" do
    it "works! (now write some real specs)" do
      get tasks_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /tasks" do
    it "creates a Task" do
      expect {
        post tasks_path, params: { task: { task_name: "New Task", state: :backlog, deadline_date: DateTime.now + 2.days } }
      }.to change(Task, :count).by(1)
    end
  end

  describe "PUT /tasks/:id" do
    it "updates a Task" do
      put task_path(task), params: { task: { state:"in_progress" } }
      task.reload
      expect(task.state).to eq("in_progress")
    end
  end

  describe "DELETE /tasks/:id" do
    it "deletes a Task" do
      task = create(:task, user: user)
      expect {
        delete task_path(task)
      }.to change(Task, :count).by(-1)
    end
  end
end
