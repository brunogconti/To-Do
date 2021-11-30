class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)
    task.save
    redirect_to tasks_path
  end

  def edit
  end

  def update
    congrats = ['Muito bem!', 'Isso aí!', 'Boa!', 'Parabéns!', 'Ótimo'].sample
    shame = ['Poxa...', 'Que pena!', '🤦‍♂️', 'Má notícia', 'Isso é ruim'].sample
    color = ['#7B68EE', '#6A5ACD', '#800000', '#2F4F4F'].sample
    set_task
    if params[:task][:completed] == '1'
      Record.create(event_type: 'Congratulations', properties: { message: congrats, color: color }, task: @task)
      @task.update(task_params)
      redirect_to task_path(@task), notice: "#{congrats}"
    else
      Record.create(event_type: 'Shame', properties: { message: shame, color: color }, task: @task)
      @task.update(task_params)
      redirect_to task_path(@task), notice: "#{shame}"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :completed)
  end
end
