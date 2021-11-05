# frozen_string_literal: true
class Rates
  require 'http'
  # setter for test purposes; i wanted to mock the response but i kept getting errors that real http connection was used
  # i will include what i tried as a comment under the tests
  attr_accessor :rates

  CNB_URL = 'https://www.cnb.cz/cs/financni-trhy/devizovy-trh/kurzy-devizoveho-trhu/kurzy-devizoveho-trhu/denni_kurz.txt'
  private_constant :CNB_URL

  # initialize the rates for conversion
  def initialize
    @rates = fetch_conversion_data
  end

  # converts the value from input currency to desired output currency
  # will raise an error unless value is a positive numeric; will raise an error if conversion rate is missing
  def convert(value, in_currency, out_currency)
    raise 'Amount must be a positive numeric' unless value.is_a?(Numeric) && value.positive?
    raise "Missing conversion rates for #{in_currency}" if @rates[in_currency].nil?
    raise "Missing conversion rates for #{out_currency}" if @rates[out_currency].nil?

    return value if in_currency == out_currency

    value.to_f * @rates[in_currency][:rate] / @rates[out_currency][:rate] / @rates[in_currency][:base] * @rates[out_currency][:base]
  end

  private

  # fetches data from CNB and parses it
  def fetch_conversion_data
    rates = {}
    # only get it once at start, assume nobody will have the cli running for a whole day or longer
    response = HTTP.get(CNB_URL).body.to_s
    # substitute commas for dots so it can be converted to floats
    response.gsub! ',', '.'
    # skip header lines
    response.split("\n").drop(2).each do |line|
      blocks = line.split('|')
      rates[blocks[3]] = { base: blocks[2].to_f, rate: blocks[4].to_f }
    end
    rates['CZK'] = { base: 1, rate: 1 }
    rates
  end
end
