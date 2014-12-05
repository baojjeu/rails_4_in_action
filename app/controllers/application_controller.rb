class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :require_signin!, :current_user

  private
    def require_signin!
      if current_user.nil?
        redirect_to signin_url,
          flash: { error: 'You need to sign in or sign up before continuing.' }
      end
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def authorize_admin!
      require_signin!

      unless current_user.admin?
        flash[:error] = 'You must be an admin to do that.'
        redirect_to root_url
      end
    end
end
