class StocksController < ApplicationController

  def search
    if params[:stock].present? # If it's not empty
      @stock = Stock.new_lookup(params[:stock])
      if @stock # If it isn't nil, see stock.rb begin and rescue. If rescued, we set it to nil.
        respond_to do |format|
          format.js { render partial: 'users/result' } # This will expect a partial that is a js file
        end
      else
        respond_to do |format|
          flash.now[:jsalert] = "Please enter a valid symbol to search"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:jsalert] = "Please enter a symbol to search" # A whole cycle is not being completed when using Ajax, since the whole page is not being reloaded, so we must use flash.now in order for the alert to only be displayed once, otherwise it will persist for another search of a different ticker as well, which we don't want.
        format.js { render partial: 'users/result' }
      end
    end
  end

end