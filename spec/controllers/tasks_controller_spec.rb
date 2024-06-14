# spec/controllers/tasks_controller_spec.rb
require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:task) { create(:task, user: user) }  # Assuming task is associated with user

  before do
    sign_in user  # Sign in the user before each example
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new Task" do
      expect {
        post :create, params: { task: { task_name: "New Task", state: "backlog", deadline_date: DateTime.now + 2.days } }
      }.to change(Task, :count).by(1)
    end
  end

  describe "PUT #update" do
    it "updates the requested task" do
      put :update, params: { id: task.to_param, task: { state: :in_progress } }
      task.reload
      expect(task.state).to eq("in_progress")
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task_to_delete = create(:task, user: user)  # Create a task associated with user
      expect {
        delete :destroy, params: { id: task_to_delete.to_param }
      }.to change(Task, :count).by(-1)
    end
  end
end
