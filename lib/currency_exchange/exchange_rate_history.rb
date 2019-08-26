module CurrencyExchange
  class ExchangeRateHistory

    attr_reader :path_to_file, :base_currency, :rates

    def initialize(path_to_file, base_currency: 'EUR')
      @path_to_file = path_to_file
      @base_currency = base_currency
      @rates = ParserFactory.call(path_to_file).output
    end

    def lookup(date, from_currency, to_currency)
      raise ArgumentError.new('Date must be a valid date object') unless date.is_a? Date

      specific_rates = rates.fetch(date.iso8601)
      
      from_rate = (from_currency == base_currency) ? 1 : specific_rates.fetch(from_currency)
      to_rate = (to_currency == base_currency) ? 1 : specific_rates.fetch(to_currency)
      to_rate/from_rate
     end
  end
end
