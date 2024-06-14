json.extract! task, :id, :task_name, :deadline_date, :state, :user_id, :notification_sent, :created_by, :created_at, :updated_at
json.url task_url(task, format: :json)
