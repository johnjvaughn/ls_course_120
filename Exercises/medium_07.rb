class GuessingGame
  def initialize(low_number, high_number)
    @number_range = low_number..high_number
    @number_of_guesses = Math.log2(high_number - low_number + 1).to_i + 1
    reset_number
  end

  def play
    reset_number
    comparison = nil
    @number_of_guesses.downto(1) do |guesses_left|
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
    @number = rand @number_range
  end

  def obtain_guess
    loop do
      puts "Enter a number between #{@number_range.first} \
and #{@number_range.last}:"
      guess = gets.to_i
      return guess if @number_range.include?(guess)
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

game = GuessingGame.new(1, 4)
game.play
