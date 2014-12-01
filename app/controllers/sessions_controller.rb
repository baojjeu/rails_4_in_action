class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:signin][:email])
    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      redirect_to root_url, flash: { success: 'Signed in successfully.' }
    else
      render :new
    end
  end
end
