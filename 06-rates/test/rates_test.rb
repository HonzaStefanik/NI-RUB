require_relative 'lib/ib/rates'
require 'test/unit'

# i didn't find naming conventions for unit tests in ruby, i decided to use the ones i know from java with snake case
class RatesTest < Test::Unit::TestCase
  Test::Unit.at_start do
    setup
  end

  def setup
    @convertor = Rates.new
    @convertor.rates['CZK'] = { base: 1.to_f, rate: 1.to_f }
    @convertor.rates['EUR'] = { base: 1.to_f, rate: 10.to_f }
    @convertor.rates['GBP'] = { base: 10.to_f, rate: 1.to_f }
  end

  def test_negative_value_expect_error
    assert_raise RuntimeError do
      @convertor.convert(-1, 'CZK', 'CZK')
    end
  end

  def test_non_numeric_value_expect_error
    assert_raise RuntimeError do
      @convertor.convert('error', 'CZK', 'CZK')
    end
  end

  def test_non_existing_in_currency_expect_error
    assert_raise RuntimeError do
      @convertor.convert(-1, 'non existent', 'CZK')
    end
  end

  def test_non_existing_out_currency_expect_error
    assert_raise RuntimeError do
      @convertor.convert(-1, 'CZK', 'nonexistent')
    end
  end

  def test_in_out_equal_expect_same_value
    val = 10
    expected_unchanged_value = 'Expected value to not change'
    assert_equal(
      10,
      @convertor.convert(val, 'CZK', 'CZK'),
      expected_unchanged_value
    )
    assert_equal(
      10,
      @convertor.convert(val, 'EUR', 'EUR'),
      expected_unchanged_value
    )
    assert_equal(
      10,
      @convertor.convert(val, 'GBP', 'GBP'),
      expected_unchanged_value
    )
  end

  def test_conversion
    assert_equal(100, @convertor.convert(10, 'CZK', 'GBP'))
  end
end

# attempt with mocking
# require 'webmock/test_unit'
# # i didn't find naming conventions for unit tests in ruby, i decided to use the ones i know from java with snake case
# class RatesTest < Test::Unit::TestCase
#   Test::Unit.at_start do
#     mock_body = '05.11.2021 #214
# země|měna|množství|kód|kurz
# Austrálie|dolar|1|AUD|16,208
# Brazílie|real|1|BRL|3,934
# Bulharsko|lev|1|BGN|12,958
# Čína|žen-min-pi|1|CNY|3,426
# Dánsko|koruna|1|DKK|3,398
# EMU|euro|1|EUR|25,275
# Filipíny|peso|100|PHP|43,605
# Hongkong|dolar|1|HKD|2,818
# Chorvatsko|kuna|1|HRK|3,360
# Indie|rupie|100|INR|29,542
# Indonesie|rupie|1000|IDR|1,531
# Island|koruna|100|ISK|16,828
# Izrael|nový šekel|1|ILS|7,043
# Japonsko|jen|100|JPY|19,299
# Jižní Afrika|rand|1|ZAR|1,445
# Kanada|dolar|1|CAD|17,622
# Korejská republika|won|100|KRW|1,849
# Maďarsko|forint|100|HUF|7,031
# Malajsie|ringgit|1|MYR|5,273
# Mexiko|peso|1|MXN|1,071
# MMF|ZPČ|1|XDR|30,919
# Norsko|koruna|1|NOK|2,556
# Nový Zéland|dolar|1|NZD|15,564
# Polsko|zlotý|1|PLN|5,490
# Rumunsko|leu|1|RON|5,106
# Rusko|rubl|100|RUB|30,839
# Singapur|dolar|1|SGD|16,217
# Švédsko|koruna|1|SEK|2,552
# Švýcarsko|frank|1|CHF|23,935
# Thajsko|baht|100|THB|65,909
# Turecko|lira|1|TRY|2,259
# USA|dolar|1|USD|21,936
# Velká Británie|libra|1|GBP|29,547'
#     WebMock.stub_request(:get, "https://www.cnb.cz/cs/financni-trhy/devizovy-trh/kurzy-devizoveho-trhu/kurzy-devizoveho-trhu/denni_kurz.txt").
#       with(
#         headers: {
#           'Connection'=>'close',
#           'Host'=>'www.cnb.cz',
#           'User-Agent'=>'http.rb/5.0.4'
#         }).
#       to_return(status: 200, body: mock_body, headers: {})
#     setup
