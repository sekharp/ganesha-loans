class ProjectsController < ApplicationController
  def index
    @projects = Project.paginate(:page => params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
