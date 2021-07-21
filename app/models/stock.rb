class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol) # Self means can directly call this method from the class, don't need an object.
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      secret_token: Rails.application.credentials.iex_client[:secret_access_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    client.price(ticker_symbol)
  end

end
