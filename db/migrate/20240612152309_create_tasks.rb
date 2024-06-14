class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.datetime :deadline_date
      t.integer :state
      t.integer :user_id
      t.boolean :notification_sent
      t.integer :created_by

      t.timestamps
    end
  end
end
