class BorrowerProjectsController < ApplicationController
  def new
    @project = Project.new
    @categories = Category.all
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      current_user.projects << @project
      redirect_to borrower_dashboard_path
    else
      flash[:error] = "Something went wrong. Make sure you fill out all fields."
      redirect_to new_borrower_project_path
    end
  end

  private

  def project_params
    params.require(:project).permit(:title,
                                    :goal_amount,
                                    :description,
                                    :category_id,
                                    :image
                                    )
  end
end
