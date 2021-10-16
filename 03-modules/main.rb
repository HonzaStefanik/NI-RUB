require_relative 'arm'
require_relative 'robot'

slash = Arm.new(5, :slasher)
grab = Arm.new(8, :grabber)

# will throw an exception
#Arm.new(8, :non_existent_arm)
#Arm.new(-8, :grabber)

robot = Robot.new("Lemur")
robot.add_arms(slash, grab)



# will throw an exception
#robot.add_arms(Arm.new(-8, :grabber))
#robot.add_arms(Arm.new(8, :non_existent_arm))


puts robot.name
robot.introduce

other_robot = Robot.new("Jenda")

puts 'first is better' if robot > other_robot


[robot, other_robot].sort
[robot, other_robot].max

robot.shout('wah')
robot.whisper('WAH')
robot.encrypt("abc")
robot.encrypt("ABC")
robot.encrypt("xyz")
robot.encrypt("XYZ")

# will throw an exception
#(1..20).each do
#  robot.add_arms(Arm.new(8, :grabber))
#end