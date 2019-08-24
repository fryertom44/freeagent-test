module CurrencyExchange
  require 'json'

  class JsonParser
    attr_reader :path

    def initialize(path)
      @path = path
    end

    def output
      obj = File.read(path)
      JSON.parse(obj)
    end
  end
end
