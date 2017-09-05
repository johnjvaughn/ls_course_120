class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

bingo_game = Bingo.new
p bingo_game.play

puts <<-QA

Q. What can we add to the Bingo class to allow it to inherit the play 
   method from the Game class?

A. Add "< Game" to the Bingo class declaration, like so:

class Bingo < Game

QA
