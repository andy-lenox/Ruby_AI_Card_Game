require File.dirname(__FILE__) + '/game.rb'

p1wins = 0
p2wins = 0

(1..10000).each do |game_no|
  game = nil
  game = Game.new(nil,nil,:robot, :robot)
  game.setup
  game.begin_game
  
  if game.winner.player_number == 1
    p1wins += 1
  end
  if game.winner.player_number == 2
    p2wins += 1
  end
  
  open('random_stats.csv', 'a') { |f|
    f.puts "#{game_no}, #{game.winner.player_number}, #{game.stats[1][:blocks]}, #{game.stats[1][:hits].size}, #{game.stats[2][:blocks]}, #{game.stats[2][:hits].size}"
  }
end

open('random_stats.csv', 'a') { |f|
   f.puts "Player 1 wins: #{p1wins}, Player 2 wins: #{p2wins}"
}