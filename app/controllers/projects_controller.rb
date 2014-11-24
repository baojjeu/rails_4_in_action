class ProjectsController < ApplicationController
  def index
  end

  def new
    @project = Project.new
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

  private
    def project_params
      params.require(:project).permit(:name, :description)
    end
end
