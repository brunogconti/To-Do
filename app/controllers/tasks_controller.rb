class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(task_params)
    task.save
    redirect_to tasks_path
  end

  def edit; end

  def update
    set_completed
    case @completed
    when @task.completed
      @task.update(task_params)
      redirect_to task_path(@task), notice: 'Nome atualizado'
    when true
      @task.update(task_params)
      set_color
      set_congrats
      create_record('Congratulations', @congrats, @color, @task)
      redirect_to task_path(@task), notice: @congrats.to_s
    when false
      @task.update(task_params)
      set_color
      set_shame
      create_record('Shame', @shame, @color, @task)
      redirect_to task_path(@task), alert: @shame.to_s
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

  def set_completed
    @completed = params[:task][:completed] == '1'
  end

  def set_color
    @color = ['#7B68EE', '#6A5ACD', '#800000', '#2F4F4F'].sample
  end

  def set_congrats
    @congrats = case @task.updated_at.strftime('%A')
                when 'Monday'
                  'Muito bem!'
                when 'Tuesday'
                  'Isso aí!'
                when 'Wednesday'
                  'Boa!'
                when 'Thursday'
                  'Parabéns!'
                when 'Friday'
                  'Parabéns!'
                else
                  'Que coisa boa!'
                end
  end

  def set_shame
    @shame = ['Poxa...', 'Que pena!', '🤦‍♂️', 'Má notícia', 'Isso é ruim'].sample
  end

  def create_record(event_type, message, color, task)
    record = Record.new(event_type: event_type, properties: { message: message, color: color }, task: task)
    record.save
  end
end
