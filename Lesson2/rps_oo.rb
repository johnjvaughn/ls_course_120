class Move
  VALUES = %w[rock paper scissors]
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def >(other_move)
    (score - other_move.score) % VALUES.size == 1
  end

  def to_s
    value
  end

  def score
    VALUES.index(value)
  end

end

class Player
  attr_accessor :move, :name

  def initialize
    score = 0
    set_name
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
    loop do
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'C3PO'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  GAME_TITLE = "Rock Paper Scissors"
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
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
    puts "#{human.name} chose #{human.move}."
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

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
