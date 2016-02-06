class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "#{@category.title} created!"
      redirect_to admin_categories_path
    else
      flash[:error] = "Something went wrong. Please enter a title."
      redirect_to new_admin_category_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end
end
