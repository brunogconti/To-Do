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
    @completed = params[:task][:completed] == '1'
    if @completed == @task.completed
      @task.update(task_params)
      redirect_to task_path(@task), notice: 'Nome atualizado'
    else
      @task.update(task_params)
      message = RecordCreator.new(event_type: @completed == true ? 'Congratulations' : 'Shame',
                                  task: @task).create_record
      redirect_to task_path(@task), notice: message
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
