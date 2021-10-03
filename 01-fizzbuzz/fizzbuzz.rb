upperBound = 100
(1..upperBound).each { |i|
  output = ""
  output += "Fizz" if i % 3 == 0
  output += "Buzz" if i % 5 == 0 && i % 3 != 0
  output += " Buzz" if i % 5 == 0 && i % 3 == 0
  output = i.to_s if output.empty?
  output += ", " if i != upperBound
  print output
}