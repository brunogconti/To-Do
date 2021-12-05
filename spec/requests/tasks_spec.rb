require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  describe 'PATCH /update' do
    it 'update task name only' do
      task = Task.create(name: 'Teste')
      patch task_url(task), params: { task: { name: 'Teste Update', completed: '0' } }
      task.reload
      expect(Record.count).to eq(0)
      expect(task.name).to eq('Teste Update')
      expect(response).to redirect_to(task_url(task))
    end

    it 'update task and create a new congrat record' do
      task = Task.create(name: 'Teste')
      patch task_url(task), params: { task: { name: 'Teste Update', completed: '1' } }
      task.reload
      expect(Record.count).to eq(1)
      record = Record.find(1)
      expect(record.event_type).to eq('Congratulations')
      expect(task.name).to eq('Teste Update')
      expect(response).to redirect_to(task_url(task))
    end

    it 'update task and create a new shame record' do
      task = Task.create(name: 'Teste', completed: '1')
      patch task_url(task), params: { task: { name: 'Teste Update', completed: '0' } }
      task.reload
      expect(Record.count).to eq(1)
      record = Record.find(1)
      expect(record.event_type).to eq('Shame')
      expect(task.name).to eq('Teste Update')
      expect(response).to redirect_to(task_url(task))
    end
  end
end
