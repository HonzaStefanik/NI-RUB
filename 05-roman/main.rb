require_relative 'roman_converter'
require_relative 'roman'
require_relative 'integer_patch'
require_relative 'string_patch'


puts RomanConverter.convert("IV")
puts RomanConverter.convert(4)

Roman.new(1000)
# will throw an error
#Roman.new(1001)
#Roman.new(0)
#Roman.new(-1)

puts 9.roman
puts 9.to_roman.class

puts "XIV".number
puts "XIV".to_roman.class

puts "ARITHMETIC OPERATIONS"
puts "====================="
first = Roman.new(4)
puts first
puts first.value
puts 1 + first
puts first + 1
puts 2 * first
puts first * 2
puts 16 / first
puts (first * 2) / 4

second = Roman.new(6)
puts second
puts first + second
puts second - first

puts [Roman.new(1), Roman.new(3), Roman.new(9)].sum

puts "COMPARISON OPERATIONS"
puts "====================="

puts Roman.new(4) == 4
puts Roman.new(5) > Roman.new(1)

puts [Roman.new(1), Roman.new(3), Roman.new(9)].min
puts [Roman.new(1), Roman.new(3), Roman.new(9)].max

puts "CONVERSION OPERATIONS"
puts "====================="

puts first.to_int
puts first.to_i
puts first.to_str
puts (1..100).first(first)
# this one doesnt work, didnt figure out how to make it work
puts (Roman.new(1)..Roman.new(5)).to_a


