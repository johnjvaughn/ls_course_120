class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

puts <<-QA

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

Q. What is the result of calling
oracle = Oracle.new
oracle.predict_the_future

A. It will return the string "You will " followed by one of the phrases
chosen randomly, with no errors.

QA

oracle = Oracle.new
p oracle.predict_the_future
