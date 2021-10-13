require_relative 'arm'
require_relative 'talkative'
require_relative 'validations'

class Robot

  include Comparable
  include Talkative
  prepend Validations

  attr_reader :name, :arms

  def initialize(name)
    @name = name
    @arms = []
  end

  def add_arms(*arms)
    arms.each { |arm| raise ArgumentError, Arm.INVALID_TYPE unless arm.is_a? Arm }
    @arms.concat(arms)
  end

  def score
    score_sum = @arms.sum(&:score)
    avg_len = @arms.sum(&:length) / @arms.length rescue 0
    score_sum + avg_len
  end

  def <=>(other)
    other.is_a?(Robot) ? score <=> other.score : nil
  end

  def output(*values)
    values.each { |value| puts value }
  end

  def introduce
    unique_arms = arms.uniq.each(&:type)
    arm_count = arms.size
    output "I am #{@name}, I have #{arm_count} arms in total. They are of types: "
    unique_arms.each { |arm| output arm.type }
  end

end