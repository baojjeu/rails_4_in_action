class ProjectsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :require_signin!, only: [:index, :show]
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.for(current_user)
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def show
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
    if @project.update(project_params)
      redirect_to @project, flash: { success: 'Project has been updated.' }
    else
      flash[:error] = 'Project has not been updated.'
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to root_url, flash: { success: 'Project has been destroyed.' }
  end

  private
    def set_project
      @project = Project.for(current_user).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'The project you were looking for could not be found.'
      redirect_to projects_path
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
