require 'minitest/autorun'
require 'minitest/pride'
require_relative 'mastermind'
require_relative 'response'
require_relative 'printer'

class MastermindTest < Minitest::Test

  def test_it_initializes
    mm = Mastermind.new
    assert_equal "continue", mm.status
    assert_equal "bgry", mm.secret
    assert_equal "bgry", mm.input
  end

  def test_input_change
    mm = Mastermind.new
    assert_equal "bgry", mm.input
    mm.execute("rrrr")
    assert_equal "rrrr", mm.input
  end

  def test_measures_short_and_long_inputs
    mm = Mastermind.new
    mm.execute("rrrrg")
    assert_equal 5, mm.input.length
    mm.execute("rrg")
    assert_equal 3, mm.input.length
  end

  def test_it_quits
    mm = Mastermind.new
    assert_equal "continue", mm.status
    mm.execute("q")
    assert_equal "won", mm.status
  end

  def test_guess_counter
    mm = Mastermind.new
    assert_equal 0, mm.guess_count
    mm.execute("bgyr")
    assert_equal 1, mm.guess_count
    mm.execute("bygr")
    assert_equal 2, mm.guess_count
  end

  def test_color_counter
    mm = Mastermind.new
    assert_equal 0, mm.color_count
    mm.execute("bgyr")
    assert_equal 4, mm.color_count
    mm.execute("rrrr")
    assert_equal 1, mm.color_count
  end

  def test_position_counter
    mm = Mastermind.new
    mm.execute("bgyr")
    assert_equal 2, mm.position_count
    mm.execute("bgrr")
    assert_equal 3, mm.position_count
  end

  def test_make_secret
    mm = Mastermind.new
    assert_equal "bgry", mm.secret
    mm.make_secret
    refute_equal "bgry", mm.secret
  end

end


class ResponseTest < Minitest::Test

  def test_response_default_status
    response = Response.new("grby", "yrgb", 2, 3, 4)
    assert_equal "grby", response.secrets
    assert_equal "yrgb", response.inputs
    assert_equal 2, response.guess_counts
    assert_equal 3, response.color_counts
    assert_equal 4, response.position_counts
  end

end


class PrinterTest < Minitest::Test

  def test_printer_default_status
    printer = Printer.new
    assert_equal "continue", printer.status
  end

  def test_printer_status_change
    printer = Printer.new
    printer.quit
    assert_equal "quit", printer.status
  end

end
