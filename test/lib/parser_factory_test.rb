class ParserFactoryTest < Test::Unit::TestCase
  def setup
    @json_file = File.expand_path(
      File.join(File.dirname(__FILE__), "..", "data", "test.json")
    )
    @xml_file = File.expand_path(
      File.join(File.dirname(__FILE__), "..", "data", "test.xml")
    )
  end

  def test_load_json_instance
    assert_instance_of CurrencyExchange::JsonParser, CurrencyExchange::ParserFactory.call(@json_file)
  end

  def test_load_unsupported_instance_fails
    assert_raise NotImplementedError.new("The class 'XmlParser' has not been implemented") do
      CurrencyExchange::ParserFactory.call(@xml_file)
    end
  end
end
