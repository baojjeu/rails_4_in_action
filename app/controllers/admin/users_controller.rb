class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(:email)
  end

  def new
    @user = User.new
  end

  def show
  end

  def edit
  end

  def update
    params = user_params.dup

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    if @user.update(params)
      flash[:success] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:error] = "User has not been updated."
      render :edit
    end
  end

  def create
    # API: http://ruby-doc.org/core-2.1.5/Object.html
    params = user_params.dup
    params[:password_confirmation] = params[:password]
    @user = User.new(params)

    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash.now[:error] = "User has not been created."
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
