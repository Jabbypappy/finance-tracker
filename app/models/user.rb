class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    stock = Stock.check_db(ticker_symbol) # Check if the stock has been searched before and added to the db
    return false unless stock
    stocks.where(id: stock.id).exists? # Check if the user is following this stock
  end

  def under_stock_limit?
    stocks.count < 10
  end
  
  def can_track_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_tracked?(ticker_symbol) # If the user has less than 10 stocks and is not tracking the stock
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    "Anonymous" # If the return is passed because there's no first_name or last_name, then "Anonymous" is reached, and it is therefore returned as the last part of the function
  end

end
