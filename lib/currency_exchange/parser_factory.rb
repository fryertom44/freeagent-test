module CurrencyExchange
  class ParserFactory

    def self.call(path_to_file)
      extension = File.extname(path_to_file)&.strip&.downcase[1..-1]
      raise ArgumentError("File must have an extension e.g. '.json'") if extension.nil?

      Object.const_get("CurrencyExchange::#{extension.capitalize}Parser").new(path_to_file)
    rescue NameError => e
      raise NotImplementedError.new("The class '#{e.name}' has not been implemented")
    end
  end
end
