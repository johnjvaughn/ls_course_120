require 'pry'

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def to_s
    marker
  end
end

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
                   [1, 4, 7], [2, 5, 8], [3, 6, 9], # columns
                   [1, 5, 9], [3, 5, 7]] # diagonals

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |num| @squares[num] = Square.new }
  end

  def clear
    system('clear') || system('cls')
  end

  def draw
    puts "#{get_label_at(1)}    |#{get_label_at(2)}    |#{get_label_at(3)}"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "#{get_label_at(4)}    |#{get_label_at(5)}    |#{get_label_at(6)}"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "#{get_label_at(7)}    |#{get_label_at(8)}    |#{get_label_at(9)}"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts ""
  end

  def get_label_at(key)
    #binding.pry
    @squares[key].unmarked? ? key : ' '
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def player_won?(player)
    WINNING_LINES.any? do |line|
      line.all? { |key| @squares[key].marker == player.marker }
    end
  end

  def winning_marker
    WINNING_LINES.each do |line|
      if @squares[line[0]].marker != Square::INITIAL_MARKER \
         && line.all? { |key| @squares[key].marker == @squares[line[0]].marker }
        return @squares[line[0]].marker
      end
    end
    return nil
  end

  def full?
    unmarked_keys.size == 0
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class Human < Player
  def move(board)
    number = nil
    empty_square_keys = board.unmarked_keys
    puts "Choose an available square (#{empty_square_keys.join(', ')}): "
    loop do
      number = gets.to_i
      break if empty_square_keys.include?(number)
      puts "Invalid choice."
    end
    board[number] = marker
  end
end

class Computer < Player
  def move(board)
    board[board.unmarked_keys.sample] = marker
  end
end

class TTTGame
  NAME_OF_GAME = "Tic Tac Toe"
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = COMPUTER_MARKER
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
  end

  def play
    display_welcome_message

    loop do
      display_board
      current_player = FIRST_TO_MOVE == HUMAN_MARKER ? human : computer
     
      loop do
        current_player.move(board)
        break if board.player_won?(current_player) || board.full?
        current_player = current_player.equal?(human) ? computer : human
        clear_screen_and_display_board if current_player.equal?(human)
      end

      display_result
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end

  private

  def display_welcome_message
    board.clear
    puts "Welcome to #{NAME_OF_GAME}!"
    puts
  end

  def display_board
    puts "You're #{TTTGame::HUMAN_MARKER}. The computer is #{TTTGame::COMPUTER_MARKER}."
    puts
    board.draw
    puts
  end

  def clear_screen_and_display_board
    board.clear
    display_board
  end

  def display_goodbye_message
    puts "Thanks for playing #{NAME_OF_GAME}. Goodbye!"
    puts
  end

  def display_result
    clear_screen_and_display_board
    winning_mark = board.winning_marker
    if winning_mark == HUMAN_MARKER
      puts "Player Won!"
    elsif winning_mark == COMPUTER_MARKER
      puts "Computer Won."
    elsif board.full?
      puts "It's a tie."
    end
    puts
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Answer must be y or n."
    end
    answer == 'y'
  end

  def reset
    board.reset
    board.clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play