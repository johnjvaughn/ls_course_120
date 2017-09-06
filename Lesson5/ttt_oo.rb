module Helpers
  # general utilities
  def joinor(items, sep = ',', conjunction = 'or')
    if items.size <= 2
      items.join(" #{conjunction} ")
    else
      items[0..-2].join("#{sep} ") + "#{sep} #{conjunction} #{items.last}"
    end
  end
end

module MatchSupport
  # methods to enable grouping TTT games into matches
  GAMES_TO_WIN_MATCH = 2 # set to 0 for simple play with no match scoring

  def display_games_to_win_match
    if GAMES_TO_WIN_MATCH > 0 && human.match_score == 0 \
       && computer.match_score == 0
      puts "First player to win #{GAMES_TO_WIN_MATCH} games wins the match."
    end
  end

  def display_match_situation_brief
    return if GAMES_TO_WIN_MATCH == 0
    print "MATCH SCORE: #{human.name} #{human.match_score}, "
    puts "#{computer.name} #{computer.match_score}"
    puts
  end

  def display_match_situation
    return if GAMES_TO_WIN_MATCH == 0
    human_name = human.name
    computer_name = computer.name
    human_score = human.match_score
    computer_score = computer.match_score
    puts <<-SCORE
MATCH SCORE
#{human_name}: #{human_score}
#{computer_name}: #{computer_score}
SCORE
    if human_score >= GAMES_TO_WIN_MATCH
      puts "#{human_name} wins the match!"
    elsif computer_score >= GAMES_TO_WIN_MATCH
      puts "#{computer_name} wins the match!"
    end
    puts
  end

  def increment_match_score(winning_marker)
    return if GAMES_TO_WIN_MATCH == 0
    if winning_marker == human.marker
      human.match_score += 1
    elsif winning_marker == computer.marker
      computer.match_score += 1
    end
  end

  def match_reset
    if human.match_score >= GAMES_TO_WIN_MATCH \
       || computer.match_score >= GAMES_TO_WIN_MATCH
      human.match_score = 0
      computer.match_score = 0
    end
  end
end

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

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "1    |2    |3"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "4    |5    |6"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "7    |8    |9"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts ""
  end
  # rubocop:enable Metrics/AbcSize

  def [](key)
    @squares[key].marker
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def all_keys
    @squares.keys
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def keys_marked_as(marker)
    @squares.keys.select { |key| @squares[key].marker == marker }
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
  end

  def full?
    unmarked_keys.empty?
  end
end

class Player
  attr_accessor :name, :marker, :match_score

  def initialize(marker)
    @marker = marker
    @match_score = 0
    @name = self.class.to_s
  end

  def choose_marker(disallowed = [])
    new_marker = marker
    loop do
      print "Enter any non-white-space character "
      print "(except #{disallowed}) " if !disallowed.empty?
      puts "to serve as #{name}'s marker:"
      new_marker = gets.chomp.strip
      break if new_marker.size == 1 && !disallowed.include?(new_marker)
      puts "Invalid entry."
    end
    @marker = new_marker
  end
end

class Human < Player
  include Helpers

  def choose_name
    loop do
      puts "Enter your name:"
      @name = gets.chomp
      break if !name.empty?
    end
  end

  def move(board)
    number = nil
    empty_square_keys = board.unmarked_keys
    puts "Choose an available square (#{joinor(empty_square_keys)}): "
    loop do
      number = gets.to_i
      break if empty_square_keys.include?(number)
      puts "Invalid choice."
    end
    board[number] = marker
  end
end

class Computer < Player
  POSSIBLE_NAMES = %w[Hal R2D2 Robby Nomad]

  def choose_name(disallowed = [])
    possible_names = POSSIBLE_NAMES - disallowed
    name_list = []
    possible_names.each_with_index do |name, index|
      name_list << "#{index + 1}. #{name}"
    end
    index = nil
    loop do
      puts "Choose a name for your Computer opponent."
      puts name_list.join(', ')
      puts "Enter the number for your choice:"
      index = gets.to_i
      break if index > 0 && index <= possible_names.size
    end
    @name = possible_names[index - 1]
  end

  def move(board)
    square_to_play = find_winning_square(board)
    square_to_play ||= find_at_risk_square(board)
    square_to_play ||= find_a_good_square(board)
    board[square_to_play] = marker
  end

  private

  def find_a_good_square(board)
    unmarked_square_keys = board.unmarked_keys
    [5, 1, 3, 7, 9].each do |key|
      return key if unmarked_square_keys.include?(key)
    end
    unmarked_square_keys.sample
  end

  def find_at_risk_square(board)
    # defensive AI:
    # look for a row/column/diag with 2 player markers and 1 open
    # space, to block (return nil if not found)
    unmarked_square_keys = board.unmarked_keys
    computer_square_keys = board.keys_marked_as(marker)
    player_square_keys = board.all_keys - unmarked_square_keys \
                         - computer_square_keys
    Board::WINNING_LINES.each do |line|
      line_player_squares = line & player_square_keys
      line_unmarked_squares = line & unmarked_square_keys
      if line_player_squares.size == 2 && line_unmarked_squares.size == 1
        return line_unmarked_squares.first
      end
    end
    nil
  end

  def find_winning_square(board)
    # offensive AI:
    # look for a row/column/diag with 2 computer markers and 1 open
    # space, to win immediately (return nil if not found)
    unmarked_square_keys = board.unmarked_keys
    computer_square_keys = board.keys_marked_as(marker)
    Board::WINNING_LINES.each do |line|
      line_computer_squares = line & computer_square_keys
      line_unmarked_squares = line & unmarked_square_keys
      if line_computer_squares.size == 2 && line_unmarked_squares.size == 1
        return line_unmarked_squares.first
      end
    end
    nil
  end
end

class TTTGame
  NAME_OF_GAME = "Tic Tac Toe"
  HUMAN_MARKER = '' # set blank to allow player to choose
  COMPUTER_MARKER = '' # set blank to allow player to choose
  WHO_GOES_FIRST = :choose # can be :human, :computer, or :choose
  include MatchSupport
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
  end

  def play
    display_welcome_message
    choose_player_names_and_markers
    board.clear

    loop do
      display_board
      player_turns
      display_result(determine_winner)
      display_match_situation
      break unless play_again?
      reset
      display_scoreboard_message
    end

    display_goodbye_message
  end

  private

  def choose_player_names_and_markers
    human.choose_name
    human.choose_marker(COMPUTER_MARKER) if HUMAN_MARKER == ''
    computer.choose_name([human.name])
    computer.choose_marker(human.marker) if COMPUTER_MARKER == ''
  end

  def alternate_player(current_player)
    current_player.equal?(human) ? computer : human
  end

  def determine_who_starts
    human_marker = human.marker
    computer_marker = computer.marker
    loop do
      puts "Which player will go first? \
(type #{human_marker} or #{computer_marker}):"
      answer = gets.chomp.strip
      return human if answer == human_marker
      return computer if answer == computer_marker
      puts "Invalid response."
    end
  end

  def player_turns
    current_player =  case WHO_GOES_FIRST
                      when :human
                        human
                      when :computer
                        computer
                      else
                        determine_who_starts
                      end
    loop do
      current_player.move(board)
      break if board.player_won?(current_player) || board.full?
      current_player = alternate_player(current_player)
      clear_screen_and_display_board if current_player.equal?(human)
    end
  end

  def display_welcome_message
    board.clear
    puts "Welcome to #{NAME_OF_GAME}!"
    puts
  end

  def display_board
    puts "Your marker is #{human.marker}. \
#{computer.name}'s is #{computer.marker}."
    display_games_to_win_match
    puts
    board.draw
    puts
  end

  def clear_screen_and_display_board
    board.clear
    display_board
  end

  def display_goodbye_message
    puts "Thanks for playing #{NAME_OF_GAME}, #{human.name}. Goodbye!"
    puts
  end

  def determine_winner
    winning_marker = board.winning_marker
    increment_match_score(winning_marker)
    winning_marker
  end

  def display_result(winning_marker)
    clear_screen_and_display_board
    if winning_marker == human.marker
      puts "#{human.name} Won!"
    elsif winning_marker == computer.marker
      puts "#{computer.name} Won."
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
      break if %w[y n].include?(answer)
      puts "Answer must be y or n."
    end
    answer == 'y'
  end

  def reset
    board.reset
    board.clear
    match_reset
  end

  def display_scoreboard_message
    puts "Let's play again!"
    puts ""
    display_match_situation_brief
  end
end

game = TTTGame.new
game.play
