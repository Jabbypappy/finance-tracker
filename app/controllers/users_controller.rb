class UsersController < ApplicationController
  def my_portfolio
    @user = current_user
    @tracked_stocks = current_user.stocks
  end

  def friends
    @friends = current_user.friends
  end

  def update_stocks
    @tracked_stocks = current_user.stocks
    Stock.update_stocks(@tracked_stocks)
    flash[:notice] = "Stocks have been updated"
    redirect_to my_portfolio_path
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def search
    if params[:friend].present? # If it's not empty
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result' } # This will expect a partial that is a js file
        end
      else
        respond_to do |format|
          flash.now[:jsalert] = "Couldn't find user"
          format.js { render partial: 'users/friend_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:jsalert] = "Please enter a friend name or email to search"
        format.js { render partial: 'users/friend_result' }
      end
    end
  end

end
