require File.dirname(__FILE__) + '/game.rb'

def start_game(p1_bot, p2_bot, number)

  no_games = 0.0
  p1wins = 0
  p2wins = 0
  p1_avg_hits = 0.0
  p1_avg_blocks = 0.0
  p2_avg_hits = 0.0
  p2_avg_blocks = 0.0

  number.times do |game_no|
    game = nil
    game = Game.new(nil,nil,:robot, p1_bot, :robot, p2_bot)
    game.setup
    game.begin_game

    if game.winner.player_number == 1
      p1wins += 1
    end
    if game.winner.player_number == 2
      p2wins += 1
    end

    p1_avg_hits += game.stats[1][:hits].size
    p1_avg_blocks += game.stats[1][:blocks]
    p2_avg_hits += game.stats[2][:hits].size
    p2_avg_blocks += game.stats[2][:blocks]
    no_games += 1

  end

  p1_avg_hits /= no_games
  p1_avg_blocks /= no_games
  p2_avg_hits /= no_games
  p2_avg_blocks /= no_games

  open('random_stats.csv', 'a') { |f|
    f.puts "#{p1_bot}, #{p2_bot}, #{p1wins}, #{p2wins}, #{p1_avg_hits}, #{p1_avg_blocks}, #{p2_avg_hits}, #{p2_avg_blocks}"
  }
end


open('random_stats.csv', 'a') { |f|
    f.puts "Player 1 bot, Player 2 bot, Player 1 wins, Player 2 wins, P1 avg hits, P1 avg blocks, P2 avg hits, P2 avg blocks"
  }
  
number_of_matches = 10
bots = [:rand,:block,:best,:better,:future,:damage]
bots.each { |x| start_game(x,x,number_of_matches) } #mirror matches
bots.permutation(2) { |x| start_game(x[0],x[1],number_of_matches) } #all others