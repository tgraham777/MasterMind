require 'colorize'

class Response
  attr_reader :secrets, :inputs, :guess_counts, :color_counts, :position_counts

  def initialize(secrets, inputs, guess_counts, color_counts, position_counts)
    @secrets = secrets
    @inputs = inputs
    @guess_counts = guess_counts
    @color_counts = color_counts
    @position_counts = position_counts
  end

  def quit_message
    puts "\nThanks for playing! You made #{@guess_counts} guesses.\nGoodbye!".green
  end

  def cheat_message
    puts "\nThe combination was #{@secrets}. You made #{@guess_counts} guesses. Come back and try again!".blue
  end

  def error_message_long
    puts "Error - input is too long or includes unacceptable characters. Please enter 4 letters (r, g, b, or y) without spaces".green
  end

  def error_message_short
    puts "Error - input is too short or includes unacceptable characters. Please enter 4 letters (r, g, b, or y) without spaces".green
  end

  def win_message
    puts "\nCongratulations! You guessed the secret combination #{@secrets} in #{@guess_counts} guesses!".green
  end

  def continue_message
    puts "#{@inputs} has #{@color_counts} of the correct elements with #{@position_counts} in the correct positions.\nYou have made #{@guess_counts} guesses. Guess again!"
  end

end
