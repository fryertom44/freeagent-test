class RunTest < Test::Unit::TestCase
  def setup
    @valid_date = Date.new(2018,11,22)
  end

  def test_output
    correct_rate = 1.2870493690602498
    assert_equal correct_rate, CurrencyExchange.rate(@valid_date, "GBP", "USD")
  end
end
