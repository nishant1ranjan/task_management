# spec/mailers/task_mailer_spec.rb
require "rails_helper"

RSpec.describe TaskMailer, type: :mailer do
  describe "deadline_alert" do
    let(:user) { create(:user) }
    let(:task) { create(:task, user: user, deadline_date: DateTime.now + 1.day) }

    it "renders the headers" do
      mail = TaskMailer.deadline_alert(task)
      expect(mail.subject).to eq("Task Deadline Alert")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['1nishantcoder@gmail.com'])
    end

    it "renders the body" do
      mail = TaskMailer.deadline_alert(task)
      expect(mail.body.encoded).to match(/This is a reminder that your task/)
    end
  end
end
