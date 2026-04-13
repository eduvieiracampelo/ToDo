class TasksController < ApplicationController
  before_action :set_project, except: [ :update_status ]
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def new
    @task = @project.tasks.new
  end

  def show
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project, notice: "Task was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:project_id])
  end

  def update
    if @task.update(task_params)
      redirect_to @project, notice: "Task was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_status
    @task = Task.find(params[:id])
    new_status = params[:status] || params.dig(:task, :status)
    if @task.update(status: new_status)
      redirect_to @task.project, notice: "Task status was updated."
    else
      redirect_to @task.project, alert: "Failed to update task status."
    end
  end

  def destroy
    @task.destroy
    redirect_to @project, notice: "Task was successfully deleted."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :due_date)
  end
end
