class TicketsController < ApplicationController
  before_action :require_signin!
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authorize_create!, only: [:new, :create]
  before_action :authorize_update!, only: [:edit, :update]
  before_action :authorize_delete!, only: :destroy

  def new
    @ticket = @project.tickets.build
    @ticket.assets.build
  end

  def show
    @comment = @ticket.comments.build
    @states = State.all
  end

  def edit

  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.user = current_user
    if @ticket.save
      redirect_to [@project, @ticket],
        flash: { success: 'Ticket has been created.' }
    else
      flash[:error] = 'Ticket has not been created.'
      render :new
    end
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to [@project, @ticket], flash: { success: 'Ticket has been updated.' }
    else
      flash[:error] = "Ticket has not been updated."
      render :edit
    end
  end

  def destroy
    @ticket.destroy
    redirect_to @project, flash: { success: 'Ticket has been deleted.' }
  end

  private
    def set_project
      @project = Project.for(current_user).find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to root_url,
        flash: { error: 'The project you were looking for could not be found.' }
    end

    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:title, :description, {assets_attributes: [:asset]})
    end

    def authorize_create!
      if !current_user.admin? && cannot?('create tickets'.to_sym, @project)
        flash[:error] = 'You cannot create tickets on this project.'
        redirect_to @project
      end
    end

    # cancancan provided helpers for current_user
    def authorize_update!
      if !current_user.admin? && cannot?('edit tickets'.to_sym, @project)
        flash[:error] = 'You cannot edit tickets on this project.'
        redirect_to @project
      end
    end

    def authorize_delete!
      if !current_user.admin? && cannot?('delete tickets'.to_sym, @project)
        flash[:error] = 'You cannot delete tickets on this project.'
        redirect_to @project
      end
    end
end
