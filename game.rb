require File.dirname(__FILE__) + '/player.rb'

class Game
  attr_accessor :player1, :player2, :play_area
  def initialize(p_1_card=nil, p_2_card=nil, p1_controller=:human, p2_controller=:human )
    @play_area = {1 => [], 2 => []}
    @player1 = Player.new(p_1_card, 1, p1_controller, @play_area)
    @player2 = Player.new(p_2_card, 2, p1_controller, @play_area)
    @current_player = @player1
  end
  
  def setup
    @player1.start_game
    @player2.start_game
  end
  
  def turn
    @current_player.turn
    #check game state after playing card
    #then apply damage, draw cards, etc.
    #check_game_state
    #apply_damage to current player if his card is not = or +- 1
    check_state  
    #make current player draw a card if his card = prev card played
    next_player
  end
  
  def next_player
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
  end
  
  def begin_game
    while !(@player1.dead and @player2.dead)
      turn
    end
    end_game
  end
  
  def check_state
    unless @play_area[@current_player.opponent].empty?
      this_turn = @play_area[@current_player.player_number][-1] || 0
      last_turn = @play_area[@current_player.opponent][-1] || 0
      #block
      if this_turn == last_turn
        @current_player.draw
        puts "Player #{@current_player.player_number} blocks and draws a card!"
        #hit
      elsif (this_turn - last_turn).abs > 1
        #take damage
        @current_player.damage((this_turn - last_turn).abs)
        puts "Player #{@current_player.player_number} takes #{(this_turn - last_turn).abs} damage!"
        #draw to full
        @current_player.draw_to
        puts "He draws up to #{@current_player.hand_size} cards"
        #clear play area
        clear_play_area
      end
    end
  end
  
  def clear_play_area
    @player1.removed = @play_area[1] + @player1.removed
    @player2.removed = @play_area[2] + @player2.removed
  end
  
  def end_game
    if @player1.dead
      @winner = @player1
    elsif @player1.dead
      @winner = @player2
    else
      "game ended prematurely"
    end
    puts "player #{@winner.player_number} wins!"
  end
  
  def print_state
    puts "It is Player #{@current_player.player_number}'s turn"
    puts "Player 1: has #{@player1.life} life remaining"
    puts "Player 2: has #{@player2.life} life remaining"
  end
end