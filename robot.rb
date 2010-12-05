class Robot

  def initialize(player)
    @player = player
  end

  def turn
    puts "Player #{@player.player_number}'s turn"
    puts "Last played: #{@player.play_area[@player.opponent][-1]}"
    puts "Cards in hand:"
    @player.hand.each_index do |index|
      print "##{index}:"
      print " #{@player.hand[index]} \n"
    end

    unless @player.hand.empty?
      choice = nil
      while choice.nil?
        choice = make_choice
      end
      
      if !@player.hand[choice].nil?
        puts "player #{@player.player_number} plays a #{@player.hand[choice]}"
        @player.play_card(choice)
      else
        @player.play_card(0)
      end
    else
      @player.play_card
    end
  end

  def make_choice
    rand(@player.hand_size)
  end

end