require 'colorize'

class Printer

  attr_accessor :status

  def initialize
    @status = "continue"
  end

  def start_menu
  puts " __  __    __    ___  ____  ____  ____  __  __  ____  _  _  ____".red
  puts "(  \\/  )  /__\\  / __)(_  _)( ___)(  _ \\(  \\/  )(_  _)( \\( )(  _ \\".yellow
  puts " )    (  /(__)\\ \\__ \\  )(   )__)  )   / )    (  _)(_  )  (  )(_) )".green
  puts "(_/\\/\\_)(__)(__)(___/ (__) (____)(_)\\_)(_/\\/\\_)(____)(_)\\_)(____/
  ".blue

  puts "Welcome to Mastermind!
Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def first_selection(input)
    if input == "i"
      instructions
    elsif input == "p"
      play
    elsif input == "q"
      quit
    else
      error
    end
  end

  def instructions
    puts "\nInstructions:".green.bold
    puts "Mastermind generates a random combination of four colors: (r)ed, (b)lue,
(g)reen, and (y)ellow. You guess a random string of four letters representing
the colors (ex: rbgy). After each guess you will get feedback on how many of the
colors are correct and how many color positions are correct. The challenge is
to see how fast you can guess the right combination of colors. Good luck!"
    puts "\n*Note: at any time during the game you can use (q)uit to end the game
or (c)heat to see the hidden sequence and exit.\n".yellow
  play
  end

  def play
    puts "\nI have generated a beginner sequence with four random elements made up of
(r)ed, (g)reen, (b)lue, and (y)ellow. At any time during the game you can use
(q)uit to end the game or (c)heat to see the hidden sequence and exit."
    puts "\nWhat's your guess?"
    @status = "continue"
  end

  def quit
    puts "\nGoodbye!".green
    @status = "quit"
  end

end
