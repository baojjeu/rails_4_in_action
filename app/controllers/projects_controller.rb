class ProjectsController < ApplicationController
  before_action :set_project, only: [:show,
                                     :edit,
                                     :update,
                                     :destroy]
  before_action :authorize_admin!, except: [:index, :show]

  def index
    @projects = Project.all
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
      @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'The project you were looking for could not be found.'
      redirect_to projects_path
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end

    def authorize_admin!
      require_signin!

      unless current_user.admin?
        flash[:error] = 'You must be an admin to do that.'
        redirect_to root_url
      end
    end
end
