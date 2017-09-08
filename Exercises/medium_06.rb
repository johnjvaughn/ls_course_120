class GuessingGame
  NUMBER_RANGE = 1..100
  NUMBER_OF_GUESSES = 7

  def initialize
    reset_number
  end

  def play
    reset_number
    comparison = nil
    7.downto(1) do |guesses_left|
      puts "You have #{guesses_left} guesses remaining."
      guess = obtain_guess
      comparison = evaluate_guess(guess)
      display_result(comparison)
      break if comparison == 0
    end
    puts "You are out of guesses. You lose." unless comparison == 0
  end

  private

  def reset_number
    @number = rand NUMBER_RANGE
  end

  def obtain_guess
    loop do
      puts "Enter a number between #{NUMBER_RANGE.first} \
and #{NUMBER_RANGE.last}:"
      guess = gets.to_i
      return guess if NUMBER_RANGE.include?(guess)
      puts "Invalid guess."
    end
  end

  def evaluate_guess(guess)
    guess <=> @number
  end

  def display_result(comparison)
    case comparison
    when -1
      puts "Your guess is too low."
    when 0
      puts "You win!"
    when 1
      puts "Your guess is too high."
    end
  end
end

game = GuessingGame.new
game.play
