require "test/unit"
require "game"

class TestGame < Test::Unit::TestCase 
  def setup
  end
  
  def test_init
    game = Game.new
    assert_equal(1, game.player1.player_number)
    assert_equal(2, game.player2.player_number)    
    assert_equal(42, game.player1.starting_cards.size)
  end
  
  def test_setup
    game = Game.new
    game.setup
    assert_equal( 37, game.player1.deck.size)
    assert_equal( 37, game.player2.deck.size)
  end
  
  def test_total_players
    game = Game.new
    game.setup
    3.times { game.player1.play_card(0) }
    1.times { game.turn }
    assert_equal( 1, game.player1.hand.size )
    1.times { game.turn }
  end
  
  def test_two_players
    game = Game.new
    game.setup
    3.times { game.player1.play_card }
    3.times { game.player2.play_card }
    assert_equal( 3, game.play_area[1].size )
    assert_equal( 3, game.play_area[2].size )
  end
  
  def test_damage
    #TODO test the check state method and whether or not
    #the correct player takes damage.
    game = Game.new
    game.setup
    assert_equal(40,game.player1.life)
    game.play_area[1].push(0)
    game.play_area[2].push(0)
    game.player1.hand[0] = 6
    game.player1.play_card(0)
    game.check_state
    assert_equal(34,game.player1.life)
  end
  
  def teardown
  end
end