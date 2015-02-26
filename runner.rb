require_relative 'mastermind'
require 'colorize'

class Runner

def start
  puts " __  __    __    ___  ____  ____  ____  __  __  ____  _  _  ____".red
  puts "(  \\/  )  /__\\  / __)(_  _)( ___)(  _ \\(  \\/  )(_  _)( \\( )(  _ \\".yellow
  puts " )    (  /(__)\\ \\__ \\  )(   )__)  )   / )    (  _)(_  )  (  )(_) )".green
  puts "(_/\\/\\_)(__)(__)(___/ (__) (____)(_)\\_)(_/\\/\\_)(____)(_)\\_)(____/
  ".blue

  puts "Welcome to Mastermind!
Would you like to (p)lay, read the (i)nstructions, or (q)uit?"

  input1 = gets.chomp.downcase
  if input1 == "i"
    puts "
Instructions:".green.bold
    puts "Mastermind generates a random combination of four colors: (r)ed, (b)lue,
(g)reen, and (y)ellow. You guess a random string of four letters representing
the colors (ex: rbgy). After each guess you will get feedback on how many of the
colors are correct and how many color positions are correct. The challenge is
to see how fast you can guess the right combination of colors. Good luck!"
    puts "
*Note: at any time during the game you can use (q)uit to end the game
or (c)heat to see the hidden sequence and exit.
".yellow
  input1 = "p"
  end

  if input1 == "p"
    timer_start = Time.now
    puts "
I have generated a beginner sequence with four random elements made up of
(r)ed, (g)reen, (b)lue, and (y)ellow. At any time during the game you can use
(q)uit to end the game or (c)heat to see the hidden sequence and exit."
    puts "
What's your guess?"

    mastermind = Mastermind.new
    mastermind.make_secret
    response = nil

    until response && response.status == :won
      print "> "
      input = gets.chomp.downcase
      input.tr!('^A-Za-z', '')
      response = mastermind.execute(input)
      puts response.message
    end
    timer_end = Time.now
    time = mastermind.timer(timer_start, timer_end)
    puts time
    puts "Do you want to (p)lay again or (q)uit?"
    input2 = gets.chomp.downcase
    if input2 == "p"
      start
    elsif input2 == "q"
      puts "Goodbye!"
    else
      puts "Do you want to (p)lay again or (q)uit?"
    end
  end

  if input1 == "q"
    puts "Goodbye!"
  end

  if input1 != "i" && input1 != "p" && input1 != "q"
    puts "Error: please enter the letter p, i, or q"
    start
  end
  end
end

  runner = Runner.new
  runner.start
