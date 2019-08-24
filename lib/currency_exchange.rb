require 'date'
require 'exchange_rate_history'

module CurrencyExchange

  class DateRangeError < StandardError; end

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency)
    # TODO: calculate and return rate


    # Plan
    # TODO: Parse the file using a parser that responds to 'rows' (or hash?). Can be xml, json, or yaml parser
    # TODO: raise error if file could not be loaded
    # TODO: raise error if any method parameters are missing (or invalid?)
    ExchangeRateHistory.new(
      'data/eurofxref-hist-90d.json'
    ).lookup(date, from_currency, to_currency)
  end
end
