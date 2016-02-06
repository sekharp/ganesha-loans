class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user = add_role(@user, params[:user][:role])
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.username}"
      redirect_to user_dashboard(current_user)
    else
      flash.now[:error] = "Something went wrong. Please try again."
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if !@user.update(user_params)
      flash[:error] = "Please enter your password"
      redirect_to edit_user_path
    else
      flash.notice = "Profile Updated!"
      redirect_to user_dashboard(current_user)
    end
  end

  def become_borrower
    current_user.roles << Role.find_by(name: "borrower")
    redirect_to borrower_dashboard_path
  end

  def become_lender
    current_user.roles << Role.find_by(name: "lender")
    redirect_to lender_dashboard_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :username,
                                 :password,
                                 :street_address,
                                 :city,
                                 :state,
                                 :zip,
                                 :bio,
                                 :image)
  end
end
