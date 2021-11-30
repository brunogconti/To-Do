class RecordController < ApplicationController
  def index
    @records = Record.all
  end

  def create
    @task = Task.find(params[:id])
    @record = Record.new(record_params)
    if @record.save!
      redirect_to edit_task_path(@task), notice: 'Curso adicionado aos favoritos!'
    else
      render 'tasks/show'
    end
  end

  private

  def record_params
    params.permit(:id)
  end
end
