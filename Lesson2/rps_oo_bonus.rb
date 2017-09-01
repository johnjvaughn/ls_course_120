class Move
  VALUES = %w[rock paper scissors spock lizard]
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def >(other_move)
    [1, 3].include?((score - other_move.score) % VALUES.size)
  end

  def to_s
    value
  end

  def score
    VALUES.index(value)
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
    @history = []
    set_name
  end

  def add_point
    @score += 1
  end

  def display_history
    print format("%12s: ", name)
    @history.each do |move|
      print format("%9s", move)
    end
    puts
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Must have a name."
    end
    self.name = n
  end

  def choose
    choice = nil
    choices = Move::VALUES.map(&:downcase)
    loop do
      puts "Please choose from: #{choices.join(', ')}"
      choice = gets.chomp.downcase
      break if choices.include?(choice)
      puts "Invalid choice."
    end
    self.move = Move.new(choice)
    @history << move
  end
end

class Computer < Player
  PERSONALITIES = { 'R2D2' => [0, 20, 20, 40, 20],
                    'Hal' => [10, 0, 90, 0, 0],
                    'C3P0' => [0, 0, 0, 50, 50] }

  def set_name
    self.name = PERSONALITIES.keys.sample
  end

  def choose
    choose_rand = rand(1..100)
    move_name = nil
    PERSONALITIES[name].each_with_index do |pctg, index|
      if pctg > choose_rand
        move_name = Move::VALUES[index]
        break
      end
      choose_rand -= pctg
    end
    self.move = Move.new(move_name)
    @history << move
  end
end

# Game Orchestration Engine
class RPSGame
  GAME_TITLE = "Rock Paper Scissors Spock Lizard"
  GAMES_TO_WIN_MATCH = 2
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_welcome_message
    clear_screen
    puts "Welcome to #{GAME_TITLE}, #{human.name}!"
    puts "Your oppenent is #{computer.name}!"
    puts
  end

  def display_goodbye_message
    puts "Thanks for playing #{GAME_TITLE}, #{human.name}. Goodbye!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n', 'yes', 'no'].include?(answer)
    end
    ['y', 'yes'].include?(answer)
  end

  def display_moves
    puts "\n#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif computer.move > human.move
      puts "#{computer.name} won."
    else
      puts "It's a tie."
    end
  end

  def award_point
    if human.move > computer.move
      human.add_point
    elsif computer.move > human.move
      computer.add_point
    end
  end

  def score_reset
    human.score = 0
    computer.score = 0
  end

  def check_match_score
    if human.score > GAMES_TO_WIN_MATCH
      puts "#{human.name} WINS THE MATCH!"
      score_reset
    elsif computer.score > GAMES_TO_WIN_MATCH
      puts "#{computer.name} WINS THE MATCH!"
      score_reset
    end
  end

  def display_match_score
    puts <<-SCOREBOARD

===================
   CURRENT SCORE
#{human.name}: #{human.score}
#{computer.name}: #{computer.score}
===================

SCOREBOARD
  end

  def display_histories
    puts <<-HISTORY

===================
  HISTORY OF MOVES
HISTORY
    human.display_history
    computer.display_history
    puts "==================="
    puts
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      award_point
      display_match_score
      check_match_score
      display_histories
      break unless play_again?
      clear_screen
    end
    display_goodbye_message
  end
end

RPSGame.new.play
