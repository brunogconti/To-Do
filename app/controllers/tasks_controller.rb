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
    color_hash = {one: '#7B68EE', two: '#6A5ACD', three: '#800000', four: '#2F4F4F'}
    color = color_hash.keys.sample
    set_task
    if params[:task][:completed] == '1'
      Record.create(event_type: 'Congratulations', properties: { message: congrats, color: color_hash[color] }, task: @task)
      @task.update(task_params)
      redirect_to task_path(@task), notice: "#{congrats}"
    else
      Record.create(event_type: 'Shame', properties: { message: shame, color: color_hash[color] }, task: @task)
      @task.update(task_params)
      redirect_to task_path(@task), alert: "#{shame}"
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
