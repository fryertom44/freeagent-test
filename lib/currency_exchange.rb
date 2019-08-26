module CurrencyExchange
  require_relative 'currency_exchange/exchange_rate_history'
  require_relative 'currency_exchange/json_parser'
  require_relative 'currency_exchange/run_via_console'
  require 'date'

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency)
    ExchangeRateHistory.new(self.file_path).lookup(date, from_currency, to_currency)
  end

  def self.file_path
    base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
    data_dir = File.join(base_dir, "data")
    @@exchange_rate_file ||= File.join(data_dir, "eurofxref-hist-90d.json")
  end

    # run via command line
  if __FILE__ == $0
    run_via_console
  end
end
