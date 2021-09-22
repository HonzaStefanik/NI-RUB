(1..100).each { |i|
  output = ""
  output += "Fizz" if i % 3 == 0
  output += "Buzz" if i % 5 == 0
  output = i if output.empty?
  puts "#{output}"
}