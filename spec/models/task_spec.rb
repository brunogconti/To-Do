require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'has a name' do
    task = Task.new({name: 'work'})
    expect(task.name).to eq('work')
    expect(task.completed).to eq(false)
  end
  it 'has a completed' do
    task = Task.new({name: 'work'})
    task.update({completed: true})
    expect(task.completed).to eq(true)
  end
end
