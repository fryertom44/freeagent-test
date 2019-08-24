require 'json_parser'

class ExchangeRateHistory

  attr_reader :path_to_file, :base_currency

  def initialize(path_to_file, base_currency: 'EUR', parser: CurrencyExchange::JsonParser)
    @path_to_file = path_to_file
    @base_currency = base_currency
    @parser = parser
  end

  def lookup(date, from_currency, to_currency)
    raise ArgumentError.new('Date must be a valid date object') unless date.is_a? Date

    all_rates = @parser.new(path_to_file).output
    specific_rates = all_rates.fetch(date.iso8601)
    [to_currency, from_currency].map do |currency|
      currency == base_currency ? 1 : specific_rates.fetch(currency)
    end.reduce(&:/)
  end
end
