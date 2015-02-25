require_relative 'response'

class Mastermind
  def execute(input)
    secret = "bgry"
    if input == "q"
      Response.new(:message => "Thanks for playing!", :status => :won)
    elsif input == "c"
      puts "The combination was #{secret}"
      Response.new(:message => "Thanks for playing!", :status => :won)
    else
      if input.length == 4
        if input == secret
          Response.new(:message => "You win!", :status => :won)
        else
          Response.new(:message => "Guess again!", :status => :continue)
          # this is where it should put feedback on how
          # many colors/positions are correct
        end
      else
        Response.new(:message => "Error: please enter 4 letters (r, g, b, or y) without spaces")
      end
    end
  end
end
