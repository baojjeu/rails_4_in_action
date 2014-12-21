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

  def make_default
    state = State.find(params[:id])
    state.default!

    redirect_to admin_states_path,
      flash: { success: "#{state} is now the default state." }
  end

  private
    def state_params
      params.require(:state).permit(:name, :background, :color)
    end
end