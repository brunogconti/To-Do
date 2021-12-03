require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "PATCH /update" do
    it "create a new congrat record" do
      task = Task.create(name: "Teste")
      patch task_url(task), params: { task: { name: 'Teste Update', completed: '1' } }
      task.reload
      expect(Record.count).to eq(1)
      record = Record.find(1)
      expect(record.event_type).to eq('Congratulations')
    end

    it "create a new shame record" do
      task = Task.create(name: "Teste")
      patch task_url(task), params: { task: { name: 'Teste Update', completed: '0' } }
      task.reload
      expect(Record.count).to eq(1)
      record = Record.find(1)
      expect(record.event_type).to eq('Shame')
    end

    it "updates the requested task" do
      task = Task.create(name: "Teste")
      patch task_url(task), params: { task: { name: 'Teste Update', completed: '1' } }
      task.reload
      expect(task.name).to eq('Teste Update')
    end

    it "redirects to the task" do
      task = Task.create(name: "Teste")
      patch task_url(task), params: { task: { name: 'Teste Update', completed: '1' } }
      task.reload
      expect(response).to redirect_to(task_url(task))
    end
  end
end
