class TaskDeadlineReminderJob < ApplicationJob
  queue_as :default

  def perform(task_id)
    task = Task.find(task_id)
    TaskMailer.deadline_alert(task).deliver_now if task.state == "backlog" || task.state == "in_progress"
  end
end
