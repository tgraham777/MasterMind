require 'minitest/autorun'
require 'minitest/pride'
require_relative 'mastermind'

class MastermindTest < Minitest::Test

  def test_initialize
    mm = Mastermind.new
    assert_equal 0, mm.guess_count
  end

  def test_default_secret
    mm = Mastermind.new
    assert_equal "bgry", mm.secret
  end

  def test_random_secret
    mm = Mastermind.new
    mm.make_secret
    refute_equal "bgry", mm.secret
  end

  def test_execute
    mm = Mastermind.new
    result = mm.execute("q")
    assert result.message.include?("Thanks for playing!")

    result = mm.execute("c")
    assert result.message.include?("The combination was")
  end

  def test_cheat_function
    mm = Mastermind.new
    input = "c"
    result = mm.execute(input)
    assert result.message.include?("Come back and try again!")
  end

  def test_input_check
    mm = Mastermind.new
    result = mm.execute("gbryg")
    assert result.message.include?("Error")

    result = mm.execute("gbry")
    assert result.message.include?("Guess again!")
  end

  def test_it_tests_too_short
    mm = Mastermind.new
    input = "bgr"
    result = mm.execute(input.downcase)
    assert result.message.include?("too short")
  end

  def test_it_tests_too_long
    mm = Mastermind.new
    input = "bgrry"
    result = mm.execute(input.downcase)
    assert result.message.include?("too long")
  end

  def test_check_winner
    mm = Mastermind.new
    result = mm.execute("bgry")
    assert result.message.include?("Congratulations!")

    result = mm.execute("gbry")
    assert result.message.include?("Guess again!")
  end

  def test_color_count
    mm = Mastermind.new
    input = "ggry"
    result = mm.execute(input)
    assert result.message.include?("3 of the correct elements")
  end

  def test_position_count
    mm = Mastermind.new
    input = "rgby"
    result = mm.execute(input)
    assert result.message.include?("2 in the correct positions")

    input = "rbgy"
    result = mm.execute(input)
    assert result.message.include?("1 in the correct positions")
  end

  def test_guess_count
    mm = Mastermind.new
    input = "gbry"
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
    mm.make_secret
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

  def test_it_quits
    mm = Mastermind.new
    input = "q"
    result = mm.execute(input)
    assert result.message.include?("Thanks for playing!")
  end

  def test_response_to_numeric_or_symbol_input
    mm = Mastermind.new
    mm.make_secret
    input = "4347"
    input.tr!('^A-Za-z', '')
    result = mm.execute(input.downcase)
    assert result.message.include?("Error")

    input = "4/5-6&8^"
    input.tr!('^A-Za-z', '')
    result = mm.execute(input.downcase)
    assert result.message.include?("Error")
  end

  def test_timer
    mm = Mastermind.new
    timer_start = Time.now
    timer_end = timer_start + 30
    result = mm.timer(timer_start, timer_end)
    assert result.include?("30")
  end

end
