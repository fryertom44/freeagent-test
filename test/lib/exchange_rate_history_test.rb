class ExchangeRateHistoryTest < Test::Unit::TestCase
  def setup
    @valid_date = Date.parse("2018-11-22")
    @valid_json = {
      "2018-11-22": {
        "USD": 1.1403,
        "JPY": 128.8,
        "BGN": 1.9558,
        "CZK": 25.99,
        "DKK": 7.4616,
        "GBP": 0.88598
      }
    }

    @history = CurrencyExchange::ExchangeRateHistory.new("rates.json")
  end

  def test_file_error
    assert_raise Errno::ENOENT do
      CurrencyExchange::ExchangeRateHistory.new("missing.json")
    end
  end

  def test_invalid_date_error
    assert_raise ArgumentError do
      @history.lookup('2019-02-02', "JPY", "CZK")
    end
  end

  def test_non_base_currency_exchange_is_correct
    assert_equal "EUR", @history.base_currency
  end

  def test_lookup_is_correct
    correct_rate = 0.20178571428571426
    assert_equal correct_rate, @history.lookup(@valid_date, "JPY", "CZK")
  end

  def test_date_not_found
    assert_raise KeyError do
      @history.lookup(Date.parse("2019-03-02"), "JPY", "CZK")
    end
  end

  def test_from_currency_not_found
    assert_raise KeyError do
      @history.lookup(@valid_date, "INVALID_CURRENCY", "CZK")
    end
  end

  def test_to_currency_not_found
    assert_raise KeyError do
      @history.lookup(@valid_date, "GBP", "INVALID_CURRENCY")
    end
  end
end
