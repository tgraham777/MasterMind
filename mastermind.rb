require_relative 'response'
require_relative 'printer'

class Mastermind

attr_reader :status, :secret, :input, :guess_count, :color_count, :position_count #note: 'count' variables are here for testing only

  def initialize
    @status = "continue"
    @secret = "bgry"
    @input = "bgry"
    @guess_count = 0
    @color_count = 0
    @position_count = 0
  end

  def make_secret
    start = "bgry"
    array1 = []
    start.length.times do
      item = start.split("").sample
      array1 << item
    end
    @secret = array1.join
    # puts "The secret is #{@secret}"
  end

  def running_loop
    make_secret
    @timer_start = Time.now
    @printer = Printer.new
    if @printer.status != "quit"
      until @status == "won"
        print "> "
        input = gets.chomp.downcase
        input.tr!('^A-Za-z', '')
        execute(input)
      end
    else
      "Goodbye!"
    end
  end

  def execute(input)
    @input = input
    if input == "q"
      response = Response.new(@secret, @input, @guess_count, @color_count, @position_count)
      @status = "won"
      response.quit_message
    elsif input == "c"
      response = Response.new(@secret, @input, @guess_count, @color_count, @position_count)
      response.cheat_message
      @status = "won"
      timer
    else
      length_check
    end
  end

  def length_check
    if @input.length > 4
      response = Response.new(@secret, @input, @guess_count, @color_count, @position_count)
      response.error_message_long
    elsif @input.length < 4
      response = Response.new(@secret, @input, @guess_count, @color_count, @position_count)
      response.error_message_short
    else
      calculator
    end
  end

  def calculator
    @guess_count += 1
    if @input == @secret
      response = Response.new(@secret, @input, @guess_count, @color_count, @position_count)
      response.win_message
      @status = "won"
      timer
    else
      color_counter
      position_counter
      response = Response.new(@secret, @input, @guess_count, @color_count, @position_count)
      response.continue_message
    end
  end

  def color_counter
    @color_count = 0
    secret = @secret.split("").uniq
    secret.map do |x|
      if @input.include?(x)
        @color_count += 1
      end
    end
  end

  def position_counter
    @position_count = 0
    @secret.split("").each_index do |i|
      if @input[i] == @secret[i]
        @position_count += 1
      end
    end
  end

  def timer
    timer_end = Time.now
    time1 = (timer_end - @timer_start).to_i
    minutes = time1 / 60
    seconds = time1 % 60
    puts "Your total time was #{minutes} minutes and #{seconds} seconds.".green
    play_again
  end

  def play_again
    puts "Want to (p)lay again or (q)uit?"
    input = gets.chomp.downcase
    if input == "p"
      @printer.start_menu
      input = gets.chomp.downcase
      @printer.first_selection(input)
      if @printer.status == "continue"
        @status = "continue"
        @guess_count = 0
        @color_count = 0
        @position_count = 0
        running_loop
      end
    else
      puts "\nGoodbye!".green
    end
  end

end
