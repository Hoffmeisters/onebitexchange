require 'rest-client'
require 'json'

class ExchangeService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
  end

 
  def perform
    begin
      exchange_api_url = ENV["CURRECY_API_URL"].to_s
      exchange_api_key = ENV["CURRECY_API_KEY"].to_s
      exchange_bitcoin_api_url = ENV["CURRECY_BTC_API_URL"].to_s
      

      if @source_currency == "BTC" or @target_currency == "BTC"
        currency = @source_currency == "BTC" ? @target_currency : @source_currency
        url = "#{exchange_bitcoin_api_url}/tobtc?currency=#{currency}&value=#{@amount}"
        res = RestClient.get url
        value = JSON.parse(res.body).to_f
        unless @target_currency == "BTC"
          value = (@amount * @amount ) / value
        end
        return value
      end

      url = "#{exchange_api_url}?token=#{exchange_api_key}&currency=#{@source_currency}/#{@target_currency}"
      res = RestClient.get url
      value = JSON.parse(res.body)['currency'][0]['value'].to_f
      
      value = value * @amount
      value
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end