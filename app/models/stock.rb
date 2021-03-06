class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true # When a Stock is being saved, it must had a valid name and a valid ticker_symbol



  def self.new_lookup(ticker_symbol) # Self means can directly call this method from the class, don't need an object.
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      secret_token: Rails.application.credentials.iex_client[:secret_access_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      new(ticker: ticker_symbol.upcase, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.update_stocks(stocks)
    stocks.each do |stock|
      Stock.update_price(stock.ticker)
    end
  end
  def self.update_price(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      secret_token: Rails.application.credentials.iex_client[:secret_access_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    stock = Stock.where(ticker: ticker_symbol).first
    stock.last_price = client.price(ticker_symbol)
    stock.save
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end



end
