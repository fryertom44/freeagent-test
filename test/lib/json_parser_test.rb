class JsonParserTest < Test::Unit::TestCase
  def setup

  end

  def test_load_file
    assert_equal(
      CurrencyExchange::JsonParser.new('test.json').output,
      {"a" => 1, "b" => 2, "c" => 3}
    )
  end

  def test_raise_error
    assert_raise Errno::ENOENT do
      CurrencyExchange::JsonParser.new('missing.json').output
    end
  end
end
