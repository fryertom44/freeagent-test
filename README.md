# FreeAgent Coding Challenge

Thank you for your interest in the FreeAgent Coding Challenge.  This template is a barebones guide to get you started.  Please add any gems, folders, files, etc. you see fit in order to produce a solution you're proud of.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Setup and Run Instructions

You can use the following steps to run the solution.  We'll use the same steps when we come to test it, but if your solution requires additional setup you can include details in the README.

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
* The `ExchangeRateHistory` class constructor has two default parameters (EUR and `JsonParser`) which allows us in future to switch base currency or parser if we choose to switch these in future. Using dependency injection for the parser allows us to support any new file format in future without needing to amend the ExchangeRateHistory class. This is the Strategy pattern - each parser class simply needs to implement an `output` method to be compatible.
* In the `CurrencyExchange.rate` method, I pass a class variable (`@@exchange_rate_file`) to the `ExchangeRateHistory` class because I wanted to pass a filepath parameter when running the file as a script (although I've left the hard-coded filepath in as a default if the class variable is missing)
* I've used the `fetch` method to retrieve values from the hash, because it raises a KeyError if the given date/currency is not found in the file. The output message is also helpful because it lists dates which are present ('Key not found. Did you mean?...')
