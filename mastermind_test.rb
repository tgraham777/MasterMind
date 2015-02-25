require 'minitest/autorun'
require 'minitest/pride'
require_relative 'mastermind'

class MastermindTest < Minitest::Test

  def test_it_wins
    mm = Mastermind.new
    input = "BGRY"
    result = mm.execute(input.downcase)
    assert result.message.downcase.include?("congratulations")
  end

  def test_it_quits
    mm = Mastermind.new
    input = "Q"
    result = mm.execute(input.downcase)
    assert result.message.include?("Thanks for playing!")
  end

  def test_it_tests_too_short
    mm = Mastermind.new
    input = "bgr"
    result = mm.execute(input.downcase)
    assert result.message.downcase.include?("too short")
  end

  def test_it_tests_too_long
    mm = Mastermind.new
    input = "bgrry"
    result = mm.execute(input.downcase)
    assert result.message.downcase.include?("too long")
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

  def test_cheat_function
    mm = Mastermind.new
    input = "C"
    result = mm.execute(input.downcase)
    assert result.message.include?("Come back and try again!")
  end

  def test_color_count
    mm = Mastermind.new
    input = "ggry"
    result = mm.execute(input.downcase)
    assert result.message.include?("3 of the correct elements")
  end

  def test_position_count
    mm = Mastermind.new
    input = "rgby"
    result = mm.execute(input.downcase)
    assert result.message.include?("2 in the correct positions")
  end

  def test_guess_count
    mm = Mastermind.new
    input = "rgby"
    result = mm.execute(input.downcase)
    assert result.message.include?("1 guesses")
  end

  def test_guess_count_multiple
    mm = Mastermind.new
    input = "rgby"
    mm.execute(input.downcase)
    input = "rrby"
    mm.execute(input.downcase)
    input = "ggrb"
    result = mm.execute(input.downcase)
    assert result.message.include?("3 guesses")
  end

  def test_it_does_not_count_mistakes
    mm = Mastermind.new
    input = "rgby"
    mm.execute(input.downcase)
    input = "rgbyg"
    mm.execute(input.downcase)
    input = "rrby"
    mm.execute(input.downcase)
    input = "ggrb"
    result = mm.execute(input.downcase)
    assert result.message.include?("3 guesses")
  end

end
