class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_congrats, :set_shame, :set_color, only: %i[update]

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
    @task.update(task_params)
    if params[:task][:completed] == '1'
      create_record('Congratulations', @congrats, @color, @task)
      redirect_to task_path(@task), notice: "#{@congrats}"
    else
      create_record('Shame', @shame, @color, @task)
      redirect_to task_path(@task), alert: "#{@shame}"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def create_record(event_type, message, color, task)
    record = Record.new(event_type: event_type, properties: { message: message, color: color }, task: task)
    record.save
  end

  def set_congrats
    @congrats = ['Muito bem!', 'Isso aí!', 'Boa!', 'Parabéns!', 'Ótimo'].sample
  end

  def set_shame
    @shame = ['Poxa...', 'Que pena!', '🤦‍♂️', 'Má notícia', 'Isso é ruim'].sample
  end

  def set_color
    @color = ['#7B68EE', '#6A5ACD', '#800000', '#2F4F4F'].sample
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :completed)
  end
end
