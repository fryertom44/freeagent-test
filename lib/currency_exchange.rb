module CurrencyExchange
  require 'file_parser'
  require 'date'
  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  def self.rate(date, from_currency, to_currency)
    # TODO: calculate and return rate


    # Plan
    # TODO: Parse the file using a parser that responds to 'rows' (or hash?). Can be xml, json, or yaml parser
    # TODO: raise error if file could not be loaded
    # TODO: raise error if any method parameters are missing (or invalid?)
    raise ArgumentError.new('Date must be a valid date object') unless date.is_a? Date
    rates = FileParser.new('data/eurofxref-hist-90d.json').parse
    rate_keys = rates.keys.map { |d| {key: d, diff: (Date.parse(d).to_time - date.to_time)} }
    .sort { |a, b| a[:diff] <=> b[:diff] }

    key = rate_keys.reject {|i| i[:diff].positive?}.last&.fetch(:key)
    raise ArgumentError.new('Date falls outside of range covered') if key.nil?

    from_rate = rates[key].fetch(from_currency)
    to_rate = rates[key].fetch(to_currency)
    to_rate/from_rate
  end
end
