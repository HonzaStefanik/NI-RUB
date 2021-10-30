# frozen_string_literal: true
require_relative 'integer_patch'
require_relative 'string_patch'

class Roman
  include Comparable

  attr_accessor :value

  UPPER_BOUND = 1000
  LIMIT_EXCEEDED = "Only numbers from 1 to #{UPPER_BOUND} are allowed."
  INVALID_TYPE = 'Only String and Integer are accepted'
  # Last MR mentioned that it was possible to add it all to one line, I didn't manage to figure out how. I kept getting this error
  # roman.rb:10:in `private_constant': constant Roman::Only String and Integer are accepted not defined (NameError)
  private_constant :UPPER_BOUND
  private_constant :LIMIT_EXCEEDED
  private_constant :INVALID_TYPE

  def initialize(value)
    case value
    when Integer
      @value = value
    when String
      @value = value.number
    else
      raise StandardError, INVALID_TYPE
    end
    raise StandardError, LIMIT_EXCEEDED if @value <= 0 || @value > UPPER_BOUND
  end

  def <=>(other)
    value <=> other.to_roman.value
  end

  def +(other)
    Roman.new(value + other.to_roman.value)
  end

  def -(other)
    Roman.new(value - other.to_roman.value)
  end

  def *(other)
    Roman.new(value * other.to_roman.value)
  end

  def /(other)
    Roman.new(value / other.to_roman.value)
  end

  def coerce(other)
    roman = Roman.new 1
    case other
    when Integer
      roman.value = other
    when String
      roman.value = other.number
    else
      raise ArgumentError, INVALID_TYPE
    end
    [roman, self]
  end

  def to_s
    RomanConverter.convert(@value)
  end

  def to_roman
    clone
  end

  alias to_i value
  alias to_int value
  alias to_str to_s
end