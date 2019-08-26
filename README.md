# FreeAgent Coding Challenge

This calculates the exchange rate between two currencies on a given date. I have used a factory class to choose the correct file parser for the exchange rate file, and dependency (constructor) injection to allow switching the base currency from EUR (default) to something else.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Setup and Run Instructions

1. Install gems:

```bash
bundle install
```

2. Run tests:

```bash
bundle exec ruby test/run_tests.rb
```

3. Start a console session:

```bash
bundle exec irb -Ilib
```

4. Load the template library:

```ruby
require 'currency_exchange'
```

5. Calculate an exchange rate:

```ruby
CurrencyExchange.rate(Date.new(2018, 11, 22), "USD", "GBP")
```

6. To run via command line:
```bash
cd lib
ruby currency_exchange.rb -f '../data/eurofxref-hist-90d.json' -d 2018-10-06 --from GBP --to USD
```
For help running the script via the command line, use:
```bash
ruby currency_exchange.rb -h
```

## Design Decisions

Here are some explanations about some of the design decisions I made.
* I created a class (`ExchangeRateHistory`) to model the exchange rate file. I wanted to generate a hash from a given file path, and also allow switching the default base currency and parser rather than hard coding them in the `CurrencyExchange` module. 
* The `ExchangeRateHistory` class constructor has a default parameter base_currency parameter (EUR) which allows us in future to switch base currency.
* The ParserFactory class chooses the correct parser class based on the file extension. To support a new format (e.g. xml, yaml) we need to create a new parser class in the currency_exchange folder, and the format of the class name needs to be "<Extension>Parser". Each parser class simply needs to implement an `output` method to be compatible (Strategy pattern).
* In the `CurrencyExchange.rate` method, I set a class/module variable (`@@file_path`) because I wanted to be able to set the filepath parameter when running as a script (although I've left the hard-coded filepath in as a default if the class variable is missing).
* I found it an awkward limitation to leave the method definition (`CurrencyExchange.rate(date, from, to)`) unchanged, because `path_to_file` and `base_currency` were extra variables that should be passed to the calculation. It didn't feel right as a stateless method; if I were to define the method definition myself, I would have defined it as an instance method of a CurrencyExchange class e.g.: `CurrencyExchange.new(path_to_file, base_currency).rate(date, from, to)`
* I've used the `fetch` method to retrieve values from the hash, because it raises a KeyError if the given date/currency is not found in the file. The output message is also helpful because it lists dates which are present ('Key not found. Did you mean?...')
