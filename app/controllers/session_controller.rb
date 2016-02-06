class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to user_dashboard(@user)
    else
      flash[:errors] = "Invalid login. Please create account or try again."
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    flash[:logout] = "Goodbye!"
    redirect_to login_path
  end
end
