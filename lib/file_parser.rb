module CurrencyExchange
  require 'json_parser'

  class FileParser
    attr_reader :parser, :path

    def initialize(path, parser = CurrencyExchange::JsonParser)
      @parser = parser
      @path = path
    end

    def parse
      @parser.new(@path).hash
    end
  end
end
