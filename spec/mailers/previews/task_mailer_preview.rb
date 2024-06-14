# spec/mailers/previews/task_mailer_preview.rb
class TaskMailerPreview < ActionMailer::Preview
    def deadline_approaching
      task = Task.first
      TaskMailer.with(task: task).deadline_approaching
    end
  end
