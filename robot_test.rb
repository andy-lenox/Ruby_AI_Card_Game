require "player"
require "robot"
require "test/unit"

class TestRobot < Test::Unit::TestCase
  def setup
    @player = Player.new(nil,1,:robot,:nil,:rand)
    @robot = Robot.new(@player)
  end
  
  def test_init
    assert_equal(@player.robot_type , @robot.type)
    p = Player.new(nil,1,:robot,:nil,:best)
    assert_equal(p.robot_type , p.controller.type)
  end
  
  def test_rand
    puts @robot.make_choice_rand
  end
  
  def test_block
     p = Player.new(nil,1,:robot,:nil,:block)
     p.hand.clear
     p.hand = [1,2,3,4,5]
     p.play_area = {1 => [], 2 => [2,3,4]}
     assert_equal(3, p.controller.make_choice_block)
  end
  
  def test_best
     p = Player.new(nil,1,:robot,:nil,:block)
     p.hand.clear
     p.hand = [1,1,1,5]
     p.play_area = {1 => [], 2 => [2,3,4]}
     assert_equal(5, p.controller.make_choice_best)
    
  end
  
end