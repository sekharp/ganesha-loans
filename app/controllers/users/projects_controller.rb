class Users::ProjectsController < ApplicationController
  def show
    @project = Project.find_by_slug(params[:id])
  end
end
