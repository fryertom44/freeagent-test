require 'date'
require 'exchange_rate_history'

module CurrencyExchange

  class DateRangeError < StandardError; end

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency)
    ExchangeRateHistory.new(
      'data/eurofxref-hist-90d.json'
    ).lookup(date, from_currency, to_currency)
  end
end
