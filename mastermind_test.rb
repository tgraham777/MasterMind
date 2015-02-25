require 'minitest/autorun'
require 'minitest/pride'
require_relative 'mastermind'

class MastermindTest < Minitest::Test
  def test_it_exists
    assert MastermindTest
  end

  def test_it_wins
    mm = Mastermind.new
    input = "BGRY"
    result = mm.execute(input.downcase)
    assert result.message.downcase.include?("win")
  end

  def test_it_quits
    mm = Mastermind.new
    input = "Q"
    result = mm.execute(input.downcase)
    assert result.message.downcase.include?("thanks")
  end

  def test_it_tests_length
    mm = Mastermind.new
    input = "bgr"
    result = mm.execute(input.downcase)
    assert result.message.downcase.include?("error")
  end

  def test_response_to_bad_guess
    mm = Mastermind.new
    input = "YRGB"
    result = mm.execute(input.downcase)
    assert result.message.downcase.include?("again")
  end

  def test_response_to_numeric_input
      mm = Mastermind.new
      input = "4347"
      input.tr!('^A-Za-z', '')
      result = mm.execute(input.downcase)
      assert result.message.downcase.include?("error")
  end

end
