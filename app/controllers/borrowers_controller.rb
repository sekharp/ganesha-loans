class BorrowersController < ApplicationController
  def new
    flash.now[:alert] = "Your cart will be lost if you register as a Borrower. #{view_context.link_to "Go Back", new_user_path}".html_safe if @cart
    @user = User.new
  end
end
