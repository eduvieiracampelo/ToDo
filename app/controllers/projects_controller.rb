class ProjectsController < ApplicationController
  def index
    @projects = Project.all.includes(:tasks).order(created_at: :desc)
    @total_projects = Project.count
    @completed_projects = Project.joins(:tasks).where(tasks: { status: "done" }).distinct.count
    @pending_projects = Project.where.not(id: Project.joins(:tasks).where(tasks: { status: "done" })).count
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, notice: "Project was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url, notice: "Project was successfully deleted."
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :start_date, :end_date)
  end
end
