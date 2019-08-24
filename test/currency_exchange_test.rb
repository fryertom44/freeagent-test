# These are just suggested definitions to get you started.  Please feel
# free to make any changes at all as you see fit.


# http://test-unit.github.io/
require 'test/unit'
require 'currency_exchange'
require 'date'

class CurrencyExchangeTest < Test::Unit::TestCase
  def setup
    @valid_date = Date.new(2018,11,22)
  end

  def test_non_base_currency_exchange_is_correct
    correct_rate = 1.2870493690602498
    assert_equal correct_rate, CurrencyExchange.rate(@valid_date, "GBP", "USD")
  end

  def test_non_base_currency_exchange_is_correct_2
    correct_rate = 0.03171241789565002
    assert_equal correct_rate, CurrencyExchange.rate(Date.parse('2018-12-03'), "HUF", "SEK")
  end

  def test_non_base_currency_exchange_is_correct_3
    correct_rate = 6.044458973520758
    assert_equal correct_rate, CurrencyExchange.rate(Date.parse('2018-12-05'), "PLN", "CZK")
  end

  def test_base_currency_exchange_is_correct
    correct_rate = 0.007763975155279502
    assert_equal correct_rate, CurrencyExchange.rate(@valid_date, "JPY", "EUR")
  end

  def test_rate_not_found
    assert_raise KeyError do
      CurrencyExchange.rate(Date.new(2017,11,22), "JPY", "EUR")
    end
  end

  def test_from_currency_not_found
    assert_raise KeyError do
      CurrencyExchange.rate(@valid_date, "INVALID_CURRENCY", "EUR")
    end
  end

  def test_to_currency_not_found
    assert_raise KeyError do
      CurrencyExchange.rate(@valid_date, "USD", "INVALID_CURRENCY")
    end
  end
end
