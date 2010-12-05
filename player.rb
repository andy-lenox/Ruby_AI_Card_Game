require File.dirname(__FILE__) + '/human.rb'
require File.dirname(__FILE__) + '/robot.rb'

class Player
  attr_reader :starting_cards, :deck, :hand, :player_number, :controller_type, :play_area, :opponent
  attr_accessor :hand_size, :removed, :discard

  @@total_players = 0

  def initialize( cards=nil, player_number=1, controller=:human, play_area=nil )
    @@total_players += 1
    #if cards aren't given to the player
    #use default deck
    unless cards
      cards = []
      6.times { cards << (0..6).to_a }
      cards.flatten!
    end

    #if play area is not defined, initialize
    #my own play area. This is mainly for testing
    unless play_area
      play_area = { player_number => [] }
    end

    @starting_cards = cards               #keep track of starting cards
    @deck           = @starting_cards.dup #your deck is made from starting cards
    @hand           = []                  #your hand 
    @hand_size      = 5                   #max number of cards you can have in hand
    @player_number  = player_number       #player 1 or 2
    @play_area      = play_area           #the pile of cards you have played
    @discard        = []                  #after play area is cleared cards go here
    @controller_type = controller          #symbol for wether human or AI controlled
    @removed        = []                  #cards removed from game due to damage 

    if @player_number == 1
      @opponent = 2
    else
      @opponent = 1
    end

    #initialize controller type
    if @controller_type == :human
      @controller = Human.new(self)
    else
      @controller = Robot.new(self)
    end
  end

  def total_players
    @@total_players
  end

  #draws cards up to passed in value
  #or the current maximum hand size
  def draw_to(max=@hand_size)
    shuffle_discard if (max - @hand.size) > @deck.size
    (max - @hand.size).times { @hand << @deck.pop }
  end

  def draw
    shuffle_discard if @deck.empty?
    @hand << @deck.pop
  end

  #plays the card at the index given
  def play_card( card = 0 )
    unless @hand.empty?
      @play_area[@player_number] << @hand[card] #add played card to the top of play area
      @hand.delete_at(card)         #returns the played card
    else
      @play_area[@player_number] << @deck.pop 
    end
  end

  #shuffle your deck and draw
  #to max hand size
  def start_game
    @deck.shuffle!
    draw_to
  end

  #return to the state after initialization
  def reset
    @deck.clear
    @hand.clear
    @play_area.clear
    @discard.clear
    @deck = @starting_cards.dup
  end

  #take a turn
  def turn
    human_turn if @controller_type == :human
    robot_turn if @controller_type == :robot
  end

  #prints out the hand, the last played card
  #of the other player, 
  def human_turn
    #todo - move this to another file
    @controller.turn
  end

  def robot_turn
    #
    @controller.turn
  end
  
  def discard
    @discard << @hand.pop
  end
  
  #players have life equal to non-removed cards
  def life
    40 - @removed.size
  end

  def damage(amount=0)
    #if there are enough cards in the deck
    #remove that many from the pile
    if @deck.size >= amount
      amount.times { @removed << @deck.pop }
      #if there are enough cards in the deck
      #and discard, shuffle your deck and discard
      #together, then do damage
    elsif ( @deck.size + @discard.size ) >= amount
      shuffle_discard
      amount.times { @removed << @deck.pop }
    else
      shuffle_discard
      #put deck into removed
      @removed = @removed + @deck
      @deck.clear
    end
  end


  #if you have 40+ cards removed from
  #your deck, you are dead
  def dead
    @removed.size >= 40
  end

  #puts your discard pile into your deck and
  #shuffles the deck.
  def shuffle_discard
    @deck = @deck + @discard
    @deck.shuffle!
    @discard.clear
  end
end

#play = {1 => [], 2 => []}
#p = Player.new(nil,1,:human,play)
#p.start_game
#p.play_area[2] << 1
#p.turn
