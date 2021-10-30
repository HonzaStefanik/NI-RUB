# converter taken from https://github.com/nadavmatalon/roman_converter
class RomanConverter

  ROMAN_NUMERALS_TABLE =
    {
      'M' => 1000,
      'CM' => 900,
      'D' => 500,
      'CD' => 400,
      'C' => 100,
      'XC' => 90,
      'L' => 50,
      'XL' => 40,
      'X' => 10,
      'IX' => 9,
      'V' => 5,
      'IV' => 4,
      'I' => 1
    }

  attr_reader :value

  def initialize(value)
    @value = value if valid?(value)
  end

  def convert
    value.class == String ? convert_roman : convert_natural
    self
  end

  def self.convert(value)
    RomanConverter.new(value).convert.value
  end

  private

  def valid?(value)
    err_msg = 'Argument must be a String or Fixnum'
    [String, Integer].include?(value.class) ? true : (fail TypeError, err_msg)
  end

  def convert_roman
    number = 0
    ROMAN_NUMERALS_TABLE.each do |numeral, natural|
      while value.index(numeral) == 0
        number += natural
        @value.slice!(numeral)
      end
    end
    @value = number
  end

  def convert_natural
    roman_str = ''
    ROMAN_NUMERALS_TABLE.map do |roman, natural|
      while value >= natural
        roman_str << roman
        @value -= natural
      end
    end
    @value = roman_str
  end
end