class Admin::ProjectsController < Admin::BaseController
  def show
    @project = Project.find_by_slug(params[:id])
    @loans = @project.loans
  end

  def update
    project = Project.find(params[:id])
    project.update(:status => params[:status])
    redirect_to admin_dashboard_index_path
  end
end
