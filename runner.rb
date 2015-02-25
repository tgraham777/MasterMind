require_relative 'mastermind'

puts "Welcome to Mastermind!
Would you like to (p)lay, read the (i)nstructions, or (q)uit?"

input1 = gets.chomp.downcase
if input1 == "i"
  puts "
Instructions:

Mastermind generates a random combination of four colors: (r)ed, (b)lue,
(g)reen, and (y)ellow. You guess a random string of four letters representing
the colors (ex: rbgy). After each guess you will get feedback on how many of the
colors are correct and how many color positions are correct. The challenge is
to see how fast you can guess the right combination of colors. Good luck!

"
input1 = "p"
end

if input1 == "p"
  puts "
I have generated a beginner sequence with four random elements made up of
(r)ed, (g)reen, (b)lue, and (y)ellow. At any time during the game you can use
(q)uit to end the game or (c)heat to see the hidden sequence and exit.

What's your guess?"

  mastermind = Mastermind.new
  response = nil

  until response && response.status == :won
    print "> "
    input = gets.chomp.downcase
    input.tr!('^A-Za-z', '')
    response = mastermind.execute(input)
    puts response.message
  end
  puts "Goodbye!"
end

if input1 == "q"
  puts "Goodbye!"
end

if input1 != "i" && input1 != "p" && input1 != "q"
  puts "Error: please enter the letter p, i, or q"
end
