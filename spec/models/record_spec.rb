require 'rails_helper'

RSpec.describe Record, type: :model do
  it 'has a event type' do
    task = Task.new({name: 'work'})
    record = Record.new({event_type: 'Shame', task: task})
    expect(record.event_type).to eq('Shame')
  end
end
