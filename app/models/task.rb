class Task < ApplicationRecord
    belongs_to :user,optional: true
    belongs_to :created_by, class_name: 'User', foreign_key: 'created_by'

    enum state: { backlog: 0, in_progress: 1, Done: 2}
    validates :task_name, presence: true
    validates :deadline_date, presence: true
    validates :state, presence: true
    validates :created_by, presence: true 
    after_save :schedule_deadline_reminders
    after_destroy :cancel_deadline_reminders

   
private

    def cancel_deadline_reminders
      # Find and delete any scheduled reminders for this task upon deletion
      Sidekiq::ScheduledSet.new.each do |job|
        job.delete if job.args.first == self.id && job.klass == "TaskDeadlineReminderJob"
      end
    end

    def schedule_deadline_reminders
      
        # Clear existing scheduled reminders for this task
      Sidekiq::ScheduledSet.new.each do |job|
        job.delete if job.args.first == self.id && job.klass == "TaskDeadlineReminderJob"
      end
  
      if self.state == "backlog" || self.state == "in_progress"
        deadline_1_day_before = deadline_date - 1.day
        deadline_1_hour_before = deadline_date - 1.hour
        
        if deadline_1_day_before > Time.current
          TaskDeadlineReminderJob.set(wait_until: deadline_1_day_before).perform_later(id)
        end
  
        if deadline_1_hour_before > Time.current
          TaskDeadlineReminderJob.set(wait_until: deadline_1_hour_before).perform_later(id)
        end
        
     end

    end
  
end
