require "player"
require "test/unit"

class TestPlayer < Test::Unit::TestCase 
  def setup
    @player = Player.new([1,2,3,4,5,6,7,8,9,10])
  end
  
  def teardown
    #nothing
  end
  
  def test_init
    assert_equal( 10, @player.starting_cards.length ) 
    assert_equal( 10, @player.deck.length ) 
  end
  
  def test_draw_to
     @player.draw_to
     assert_equal( 5, @player.hand.length )
     assert_equal( 5, @player.deck.length )
  end
  
  def test_change_hand_size
    @player.hand_size = 6
    @player.draw_to
    assert_equal( 6, @player.hand.length )
    assert_equal( 4, @player.deck.length )
  end
  
  def test_play_card
    @player.draw_to
    assert_equal( 6, @player.hand.last )
    assert_equal( 6, @player.play_card(-1) )
    assert_equal( 1, @player.play_area.length )
    assert_equal( 6, @player.play_area[1][-1] )
  end
  
  def test_default_init
    #
  end
  
  def tests_start_reset
    p = Player.new
    puts "deck = #{p.deck}"
    p.start_game
    puts "deck = #{p.deck}"
    assert_equal( 42, p.starting_cards.length )
    assert_equal( 37, p.deck.length )
    assert_equal( 5,  p.hand.length )
    p.reset
    assert_equal( 42, p.deck.length )
    assert_equal( 0, p.hand.length )
  end
  
  def test_controller
    p = Player.new
    assert_equal(:human, p.controller_type)
    p = Player.new(nil,1,:robot)
    assert_equal(:robot, p.controller_type)
  end
  
  def test_play_area
    p = Player.new
    puts "the play area looks like this: #{p.play_area}"
  end
  
  def test_life_total
    p = Player.new
    assert_equal(40, p.life)
    p.damage(4)
    assert_equal(36, p.life)
    p.damage(36)
    assert_equal(0, p.life)
    assert_equal(true, p.dead)
  end
  
  def test_play_area
    play_area = { 1 => [], 2 => [] }
    p = Player.new(nil,1,:human,play_area)
    p.play_card(0)
    assert_equal( play_area, p.play_area)
    assert_equal( play_area[1], p.play_area[1])
    p2 = Player.new(nil,2,:human,play_area)
    p.play_card(1)
    assert_equal( play_area, p2.play_area)
    assert_equal( play_area[1], p2.play_area[1])
    assert_equal( p.play_area, p2.play_area)
  end
end

