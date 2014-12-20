class Admin::StatesController < Admin::BaseController
  def index
    @states = State.all
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(state_params)
    if @state.save
      redirect_to admin_states_path, flash: { success: 'State has been created.' }
    else
      render :new
    end
  end

  private
    def state_params
      params.require(:state).permit(:name, :background, :color)
    end
end