require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "PATCH /update" do
    it "updates the requested task" do
      task = Task.create(name: "Teste")
      get edit_task_url(task)
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
