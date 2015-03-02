require_relative 'mastermind'
require_relative 'printer'

  printer = Printer.new
  printer.start_menu
  input = gets.chomp.downcase
  printer.first_selection(input)
  if printer.status != "quit"
    mastermind = Mastermind.new
    mastermind.running_loop
  end
