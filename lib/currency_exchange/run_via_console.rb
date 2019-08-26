module CurrencyExchange
  require 'optparse'
  require 'optparse/date'

  def self.run_via_console
    begin
    # default options:
    options = {verbose: false}
    
    OptionParser.new do |opts|
      # banner and separator are the usage description showed with '--help' or '-h'
      opts.banner = "Usage: currency_exchange.rb [options]"
      opts.separator "Returns the conversion rate from the given file using the parameters given"
      opts.separator "Options:"
      # options (switch - true/false)
      opts.on("-v", "--verbose", "Verbose mode") do |v|
        options[:verbose] = v
      end
      opts.on("-f", "--file FILE", "Path to file containing exchange rates (currently only supports JSON)") do |f|
        options[:file] = f
      end
      opts.on("-d", "--date [DATE]", Date, "Date of exchange rate") do |d|
        options[:date] = d
      end
      opts.on("--from CURRENCY", "From Currency (e.g. USD)") do |f|
        options[:from] = f
      end
      opts.on("--to CURRENCY", "To Currency (e.g. GBP)") do |t|
        options[:to] = t
      end
      opts.on("-h", "--help", "Prints help") do
        puts opts
        exit
      end
    end.parse!

   # Exchange rate file used by ExchangeRateHistory
    @@file_path = options[:file]

    if options[:verbose]
      puts <<~HEREDOC
        ......................................................
        Date: #{options[:date]}
        Calculating rate from: #{options[:from]} to: #{options[:to]}
        ......................................................
      HEREDOC
    end

    rate = CurrencyExchange.rate(*options.values_at(:date, :from, :to))
    puts "=> #{rate}"

    rescue StandardError => e
      print "#{e}\n"
    end
  end
end
