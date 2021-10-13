# frozen_string_literal: true
class Arm
  attr_reader :type, :length

  ARM_VALUES = {
    poker: 1,
    slasher: 3,
    grabber: 5
  }.freeze
  INVALID_LENGTH = 'Length must be of Numeric and must be positive'
  INVALID_TYPE = 'Arm type must be one of [poker, slasher, grabber]'
  private_constant :ARM_VALUES
  private_constant :INVALID_LENGTH
  private_constant :INVALID_TYPE

  def initialize(length, type)
    raise ArgumentError, INVALID_LENGTH unless (length.is_a? Numeric) && length.positive?
    raise ArgumentError, INVALID_TYPE unless ARM_VALUES.keys.include? type

    @length = length
    @type = type
  end

  def score
    ARM_VALUES[@type]
  end
end
