class Users::CartProjectsController < ApplicationController
  def new
    @project = Project.find(params[:project])
  end

  def create
    project = Project.find(params[:cart_project][:project_id])
    amount = params[:cart_project][:amount].to_f

    if valid_amount?(amount, project)
      @cart.add_project(project.id, amount)
      session[:cart] = @cart.contents

      flash[:success] = "Added #{view_context.link_to "#{project.title}", user_project_path(user: project.user.slug, id: project.slug)} loan to your cart.".html_safe
      redirect_to cart_index_path
    else
      flash[:error] = "Please enter a valid amount"
      redirect_to new_user_cart_project_path(user: project.user.slug, project: project)
    end
  end

  def update
    project = Project.find(params[:id])
    amount = params[:project][:amount].to_f

    if valid_amount?(amount, project)
      @cart.update_loan(project.id, amount)
      session[:cart] = @cart.contents
      flash[:success] = "Successfully updated loan amount."
    else
      flash[:error] = "Sorry! That's not a valid loan amount."
    end
    redirect_to cart_index_path
  end

  def destroy
    project = Project.find(params[:id])
    @cart.remove_project(project.id)
    session[:cart] = @cart.contents
    flash[:success] = "Successfully removed #{view_context.link_to "#{project.title}", user_project_path(user: project.user.slug, id: project.slug)} loan from your cart.".html_safe
    redirect_to cart_index_path
  end
end
