class Human
  
  attr_accessor :type
  
  @type = :none
  
  
  def initialize(player)
    @player = player
  end
  
  def turn
    #todo - move this to another file
    puts "Player #{@player.player_number}'s turn"
    puts "Last played: #{@player.play_area[@player.opponent][-1]}"
    puts "Cards in hand:"
    @player.hand.each_index do |index|
      print "##{index}:"
      print " #{@player.hand[index]} \n"
    end

    done = false
    unless @player.hand.empty?
      while !done
        puts "Select a card to play:"
        choice = gets
        choice = Integer(choice)
        if (choice >= 0 and choice < @player.hand.size)
          @player.play_card(choice)
          done = true
        else
          puts "Invalid selection, Choose again:"
        end
      end
    else
      #play the top card of the deck.
      puts "Hand Empty, playing from the top of the deck"
      @player.play_card
    end
  end
end