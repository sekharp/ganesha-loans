class Admin::DashboardController < Admin::BaseController
  def index
    @projects = Project.all
  end

  def show
    @admin = current_user
    @projects = Project.where(status: "Pending")
  end
end
