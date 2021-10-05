# frozen_string_literal: true
class Calculator
  attr_writer :name

  INVALID_TYPE = 'Argument(s) must be of type Numeric'
  INVALID_EXTREME = 'Extreme value can be either :min or :max'
  private_constant :INVALID_TYPE
  private_constant :INVALID_EXTREME

  def initialize(init_value = 0, name = '')
    @name = name
    @result = init_value.to_f
    @init_value = init_value.to_f
  end

  class << self
    def extreme(extreme, vals)
      raise ArgumentError(INVALID_EXTREME) unless %i[min max].include? extreme
      raise TypeError(INVALID_TYPE) unless vals.all? { |val| val.is_a? Numeric }

      vals.public_send(extreme)
    end

    def number?(val)
      val.is_a? Numeric
    end
  end

  def name
    @name.nil? ? nil : @name.upcase
  end

  def reset
    @result = @init_value.to_f
    self
  end

  # cosmetic change to print integers without trailing zeroes
  # taken from https://stackoverflow.com/questions/18533026/trim-a-trailing-0
  def result
    i = @result.to_i
    f = @result.to_f
    i == f ? i : f
  end

  def add(*vals)
    raise TypeError(INVALID_TYPE) unless vals.all? { |val| val.is_a? Numeric }

    vals.all? { |val| @result += val.to_f }
    self
  end

  def sub(val)
    raise TypeError(INVALID_TYPE) unless val.is_a? Numeric

    @result -= val.to_f
    self
  end

  def mult(val)
    raise TypeError(INVALID_TYPE) unless val.is_a? Numeric

    @result *= val.to_f
    self
  end

  def div(val)
    raise TypeError(INVALID_TYPE) unless val.is_a? Numeric
    raise ZeroDivisionError if val.zero?

    @result /= val.to_f
    self
  end
end