class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  add_flash_types :success, :info, :warning, :danger
  helper_method :current_user

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def current_permission
    @current_permission ||= PermissionService.new(current_user)
  end

  def authorize!
    unless authorized?
      redirect_to root_url, danger: "Stranger danger!"
    end
  end
  before_action :authorize!

  def authorized?
    current_permission.allow?(params[:controller], params[:action])
  end

  def valid_amount?(amount, project)
    amount > 0 && amount <= project.goal_amount
  end

  def add_role(user, role)
    user.roles << Role.find_by(name: params[:user][:role])
    @cart.contents = {} if role == 'borrower'
    user
  end

  def user_dashboard(user)
    if user.admin?
      admin_dashboard_path(id: user.id)
    elsif user.borrower?
      borrower_dashboard_path
    else
      if @cart.contents.empty?
        lender_dashboard_path(id: user.id)
      else
        cart_index_path
      end
    end
  end

  def not_found
  end
end
