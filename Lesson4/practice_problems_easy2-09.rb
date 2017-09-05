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

puts <<-QA

Q. What would happen if we added a play method to the Bingo class, keeping 
   in mind that there is already a method of this name in the Game class 
   that the Bingo class inherits from.

A. Bingo's play method would override Game's play method on all objects of
   class Bingo.

QA
