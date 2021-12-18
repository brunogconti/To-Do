require 'rails_helper'

RSpec.describe RecordCreator do
  before(:each) do
    @task = Task.create(name: 'Work')
    @task.update(name: 'Work', completed: true)
  end

  context 'creating task' do
    it 'has a record with a string type message' do
      message = RecordCreator.new({ task: @task, event_type: 'Congratulations' }).create_record
      expect(Record.count).to eq(1)
      expect(message).to be_a(String)
    end
  end
end
