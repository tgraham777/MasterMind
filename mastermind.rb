require_relative 'response'
require 'colorize'

class Mastermind

  def initialize
    @guess_count = 0
    @secret = "bgry"
  end

  def make_secret
    start = "bgry"
    @secret = start.split("").shuffle.join
  end

  def timer(timer_start, timer_end)
    time1 = (timer_end - timer_start).to_i
    minutes = time1 / 60
    seconds = time1 % 60
    "Your total time was #{minutes} minutes and #{seconds} seconds.".green
  end

  def execute(input)
    if input == "q"
      Response.new(:message => "Thanks for playing! You made #{@guess_count} guesses.".red, :status => :won)
    elsif input == "c"
      Response.new(:message => "The combination was #{@secret}. You made #{@guess_count} guesses. Come back and try again!".blue, :status => :won)
    else
      if input.length > 4
        Response.new(:message => "Error - input is too long or includes unacceptable characters. Please enter 4 letters (r, g, b, or y) without spaces".green)
      elsif input.length < 4
        Response.new(:message => "Error - input is too short or includes unacceptable characters. Please enter 4 letters (r, g, b, or y) without spaces".green)
      else
        @guess_count += 1
        if input == @secret
          Response.new(:message => "Congratulations! You guessed the secret combination #{@secret} in #{@guess_count} guesses!".green, :status => :won)
        else
          color_count = 0
          @secret.split("").map do |x|
            if input.include?(x)
              color_count += 1
            end
          end

          position_count = 0
          @secret.split("").each_with_index.map do |x,i|
            if input[i] == @secret[i]
              position_count += 1
            end
          end
          Response.new(:message => "#{input} has #{color_count} of the correct elements with #{position_count} in the correct positions.
You have made #{@guess_count} guesses. Guess again!", :status => :continue)
        end
      end
    end
  end
end
