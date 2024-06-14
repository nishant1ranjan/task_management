# README

This README would normally document whatever steps are necessary to get the
application up and running.

** Google calender integration is done, but will not work because the direction url is in localhost.However I modify this using ngrok if you want.**

Things you may want to cover:


* Ruby version "2.7.6"

* Rails version  7.1.3.4


Install MySQL 8.0.37 on your local machine
https://dev.mysql.com/doc/mysql-getting-started/en/


Install Redis 7.2.5:
https://redis.io/docs/latest/operate/oss_and_stack/install/install-redis/
Make sure redis is running by command "redis-cli ping"

* Install dependies: bundle install

* Create db: RAILS_ENV=development rails db:create
* Create test db: RAILS_ENV=test rails db:create

* Create active storage for profile picture 
    rails active_storage:install
* Run database migrations: rails db:migrate

* Start Sidekiq: bundle exec sidekiq

* Start rails server: rails server



Usage
Creating Tasks:

Visit http://localhost:3000/tasks/new to create a new task.
Enter task details including name, deadline, and status.
Updating Tasks:

Visit http://localhost:3000/tasks/:id/edit to update task details.
Email Reminders: 

Visit http://localhost:3000/sidekiq/scheduled to see the scheduled jobs.

Sidekiq will automatically schedule email reminders 1 day and 1 hour before each task's deadline.
Ensure your environment (config/environments/development.rb or config/environments/production.rb) is configured to send emails.
Implementation Details
Models:

Task: Represents a task with attributes name, deadline, status, and user_id.
Background Jobs:

TaskDeadlineReminderJob: Sends email reminders to users before task deadlines.
Emails:

TaskMailer: Sends email notifications using Action Mailer.
Scheduling:

Tasks are monitored for changes in status or deadline updates. On save, existing reminders for the task are cleared, and new reminders are scheduled based on the updated deadline.

Google calender is implemented by using service object design pattern inside app/services/google_calendar_service.rb . But will not work fully because it will require https redirection link.Which can be achived by using "ngrok" command in local.But the problem is that https url generated by ngrok differ.So it needs to be updated on google calender setting on app registered on my email.


To run rails server and sidekiq server in background you can use "nohup" command but it's disadvantage is that the server will be killed on syatem shut down.Use systemctl to avoid the situation you can finnd more details here:
https://medium.com/the-blockchain-artist/running-ruby-on-rails-5-application-as-systemctl-6fbe961e72dc

* Rspec is being used for testing you can visit spec folder to view the test cases.You can also rin the test cases using "bundle exec rspec".
