class TaskMailer < ApplicationMailer
  default from: '1nishantcoder@gmail.com'

  def deadline_alert(task)
    @task = task
    mail(to: @task.user.email, subject: 'Task Deadline Alert')
  end
end
