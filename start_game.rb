require File.dirname(__FILE__) + '/game.rb'

game = nil
game = Game.new(nil,nil,:human, :robot)

=begin
if ARGV.empty?
  game = Game.new
  puts "Player1: Human"
  puts "Player2: Human"
elsif ARGV.size == 1
  puts "Player1: Human"
  puts "Player2: #{ARGV[1]}"
  game = Game.new(nil,nil,:human, :robot)
elsif ARGV.size == 2  
  puts "Player1: #{ARGV[1]}"
  puts "Player2: #{ARGV[2]}"
  game = Game.new(nil,nil,:robot, :robot)
else
  puts "invalid arguments"
  return 0
end
=end
game.setup
game.begin_game