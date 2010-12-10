class Robot

  attr_accessor :type

  def initialize(player, r_type)
    @player = player
    @robot_type = r_type
    puts "I am a #{@robot_type} robot"
  end

  def turn
    puts "Player #{@player.player_number}'s turn"
    puts "Last played: #{@player.play_area[@player.opponent][-1]}"
    puts "Cards in hand:"
    @player.hand.each_index do |index|
      print "##{index}:"
      print " #{@player.hand[index]} \n"
    end
    puts "robot type: #{@robot_type}"
    unless @player.hand.empty?
      choice = nil
      while choice.nil?
        if @robot_type == :rand
          choice = make_choice_rand
        elsif @robot_type == :block
          choice = make_choice_block
        elsif @robot_type == :best
          choice = make_choice_best
        elsif @robot_type == :future
          choice = make_choice_future
        elsif @robot_type == :distance
          choice = make_choice_distance
        elsif @robot_type == :damage
          choice = max_damage
        elsif @robot_type == :better
          choice = make_choice_better
        else
          #choice = 0
        end
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

  def make_choice_rand
    puts "Choosing random"
    rand(@player.hand_size)
  end

  def make_choice_block
    puts "Trying to block!"
    last = @player.play_area[@player.opponent][-1]
    choice = @player.hand.index(last)
    if choice
      return choice
    end
    rand(@player.hand_size)
  end

  def make_choice_best
    puts "Trying to block! or counter attack!"
    last = @player.play_area[@player.opponent][-1] || 0
    choice = @player.hand.index(last)
    choice = @player.hand.index(last+1) if !choice
    choice = @player.hand.index(last-1) if !choice
    if choice
      return choice
    end
    return rand(@player.hand_size) 
  end

  def make_choice_distance
    last = @player.play_area[@player.opponent][-1] || 0
    rand(@player.hand_size)
  end

  def future_mkII
    last = @player.play_area[@player.opponent][-1] || 0
    hand = Array.new(@player.hand)
    choice = hand.index(last) 
    
    #match
    return choice if !choice.nil?
  
    plus_one = @player.hand.index(last+1)
    minus_one = @player.hand.index(last-1)
    
    #xor
    if plus_one.nil? ^ minus_one.nil?
      return minus_one if plus_one.nil?
      return plus_one if minus_one.nil?
    end
    
    #both
    if plus_one and minus_one
      return longest_string(hand,last) #longest string of concecutive ints based around last played
    end
    
    #neither
    if plus_one.nil and minus_one.nil
      return longest_string(hand) #center of concecutive ints
    end
    #no clue
    return 0
  end
  
  def longest_string(hand, last=nil, length=0)
    #[1,2,3,4,5]
    #[2,2,3,3,3]
    #[0,6,3]
    #[2,3,4,3]
    if last
      hand.delete(last)
      hand.sort.each do |card|  
        if card == last
          last = card
        elsif card == (last + 1)
          last = card + 1
        elsif card == (last - 1)
          last = card - 1
        end
      end
      length += longest_string(Array.new(hand), last, length) 
    end
    return length
  end

  def make_choice_future
    last = @player.play_area[@player.opponent][-1] || 0
    hand = @player.hand.dup


    choice = @player.hand.index(last)
    return choice if !choice.nil?
    
    plus_one = @player.hand.index(last+1) if !choice
    minus_one = @player.hand.index(last-1) if !choice
    
    if plus_one.nil? ^ minus_one.nil?
      return minus_one if plus_one.nil?
      return plus_one if minus_one.nil?
    end
  

    direction = 0
    hand.each do |card|
      if card
        if card > last
          direction += 1
        elsif card < last
          direction -= 1
        end # card greater or less
      end
    end
    puts "direction = #{direction}"

    if direction > 0
      choice = @player.hand.index(last+2)
      choice = @player.hand.index(last+3) if !choice
      choice = @player.hand.index(last+4) if !choice
      choice = @player.hand.index(last+5) if !choice
      choice = @player.hand.index(last+6) if !choice
    elsif direction < 0
      choice = @player.hand.index(last-2) 
      choice = @player.hand.index(last-3) if !choice
      choice = @player.hand.index(last-4) if !choice
      choice = @player.hand.index(last-5) if !choice
      choice = @player.hand.index(last-6) if !choice
    elsif direction == 0
      (0..6).each do |num|
        choice = @player.hand.index(last+num) if !choice
        choice = @player.hand.index(last-num) if !choice
      end
    end #if direction

    puts "choice = #{choice}"
    if !choice.nil?
      return choice
    end
    return 0
  end # function

  def max_damage
    last = @player.play_area[@player.opponent][-1] || 0
    choice = @player.hand.index(0) if last == 1
    choice = @player.hand.index(6) if last == 5
    (0..6).each do |num|
      choice = @player.hand.index(last+num) if !choice
      choice = @player.hand.index(last-num) if !choice
    end
    if choice
      return choice
    end
    return rand(@player.hand_size)
  end



  def make_choice_better
    puts "Trying to block! or counter attack!"
    last = @player.play_area[@player.opponent][-1] || 0
    (0..6).each do |num|
      choice = @player.hand.index(last+num) if !choice
      choice = @player.hand.index(last-num) if !choice
    end
    if choice
      return choice
    end
    return rand(@player.hand_size)
  end


end