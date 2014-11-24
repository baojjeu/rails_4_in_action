class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, flash: { success: 'Project has been created.' }
    else
      flash[:error] = 'Project has not been created.'
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to @project, flash: { success: 'Project has been updated.' }
    else
      render :edit
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
