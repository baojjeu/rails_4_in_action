class CommentsController < ApplicationController
  before_action :require_signin!
  before_action :set_ticket

  def create
    @comment = @ticket.comments.build(comment_params)
    if @comment.save
      redirect_to [@ticket.project, @ticket],
          flash: { success: 'Comments has been created.' }
    else
      flash[:error] = 'Comment has not been created.'
      render template: 'tickets/show'
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def comment_params
      params.require(:comment).permit(:text)
    end
end
