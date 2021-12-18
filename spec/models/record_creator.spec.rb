require 'rails_helper'

RSpec.describe RecordCreator do
  before(:each) do
    @task = Task.create(name: 'Work', completed: true)
  end

  context 'creating task' do
    it 'has a invoice with Contratulations event type' do
      result = RecordCreator.new({task_id: @task.id}).create_record
      expect(result).to eq('Contratulations')
    end
  end
end
