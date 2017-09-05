class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
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

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

Q. What is the result of the following:
trip = RoadTrip.new
trip.predict_the_future

A. It will return the string "You will " followed by one of the phrases
chosen randomly from RoadTrip's method choices ("Vegas", "Fiji" or "Rome")

QA

trip = RoadTrip.new
p trip.predict_the_future
