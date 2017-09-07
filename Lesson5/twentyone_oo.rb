module Helpers
  def prompt(message)
    puts "=> #{message}"
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def user_choice(question, choices = { 'yes' => 'y', 'no' => 'n' })
    # question: a string to output to the user (possibly many times until
    # input is valid)
    # choices: hash whose keys are full word versions of each choice
    # and whose values (if not nil) are abbreviated versions
    choices_out = []
    choices_comp = {}
    choices.each do |full, abbr|
      choices_out << abbr ? full.gsub(abbr, "(#{abbr})") : full
      choices_comp[full.downcase] = abbr ? abbr.downcase : nil
    end

    prompt_line = "#{question} (#{choices_out.join('/')})"
    loop do
      prompt prompt_line
      answer = gets.strip.downcase
      return answer if choices_comp.key?(answer)
      return choices_comp.key(answer) if choices_comp.value?(answer)
    end
  end

  def user_string(question)
    # prompt for and return a string from the user, such as a name
    response = nil
    loop do
      prompt question
      response = gets.chomp.strip
      break unless response.empty?
    end
    response
  end
end

class Card
  attr_reader :rank, :suit
  attr_accessor :face_up

  def initialize(rank, suit, status = 'up')
    @rank = rank
    @suit = suit
    @face_up = status == 'up'
  end

  def to_s
    face_up ? "#{rank}#{suit}" : "??"
  end
end

class Shoe
  # 'Shoe' rather than 'Deck' to allow for possibility of multiple decks
  RANKS = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']
  SUITS = ['C', 'D', 'H', 'S']
  attr_reader :num_decks

  def initialize(num_decks = 1)
    @num_decks = num_decks
  end

  def shuffle
    @cards.shuffle!
  end

  def deal_one_card
    @cards.pop
  end

  def collect_cards
    @cards = []
    num_decks.times do
      RANKS.each do |rank|
        SUITS.each { |suit| @cards << Card.new(rank, suit) }
      end
    end
  end
end

class Hand
  attr_reader :cards

  def initialize(shoe, status = 'up')
    @cards = [shoe.deal_one_card, shoe.deal_one_card]
    @cards.first.face_up = false unless status == 'up'
  end

  def to_s
    str = "==> " + cards.map(&:to_s).join(', ')
    if cards.first.face_up
      str << " (#{total})"
      str << " BLACKJACK!" if bj?
      str << " BUSTED" if bust?
    end
    str
  end

  def total
    ranks = cards.map(&:rank)
    sum = 0
    ranks.each do |rank|
      sum += if rank == 'A'
               11
             elsif rank.to_i == 0
               10
             else
               rank.to_i
             end
    end

    ranks.select { |rank| rank == 'A' }.count.times do
      sum -= 10 if sum > TwentyOneGame::BUST_IF_OVER
    end
    sum
  end

  def hit(shoe)
    @cards << shoe.deal_one_card
  end

  def bust?
    total > TwentyOneGame::BUST_IF_OVER
  end

  def perfect?
    total == TwentyOneGame::BUST_IF_OVER
  end

  def bj?
    perfect? && cards.size == 2
  end

  def put_face_up
    @cards.first.face_up = true
  end
end

class Participant
  include Helpers
  attr_reader :name, :hand, :result

  def to_s
    format "%13s has %s", name, hand
  end

  def play(shoe)
    return record_result('bj') if hand.bj?
    loop do
      return stand if make_decision == 'stand'
      hit(shoe)
      return record_result('bust') if hand.bust?
      return record_result(hand.total) if hand.perfect?
    end
  end

  def total
    return 'bj' if hand.bj?
    hand.total
  end

  def stand
    record_result(hand.total)
    prompt "#{name} stands with #{hand.total}."
  end

  def hit(shoe)
    prompt "#{name} hits!"
    hand.hit(shoe)
    puts self
    sleep 1
  end

  def record_result(result)
    @result = result
  end

  def deal_new_hand(shoe)
    @hand = Hand.new(shoe)
  end
end

class Dealer < Participant
  STAND_AT_TOTAL = 17

  def initialize(name)
    @name = name
  end

  def show_hand
    hand.put_face_up
    puts self
    hand.total
  end

  def play(shoe)
    show_hand
    super
  end

  def deal_new_hand(shoe)
    @hand = Hand.new(shoe, 'one_down')
  end

  private

  def make_decision
    hand.total >= STAND_AT_TOTAL ? 'stand' : 'hit'
  end
end

class Player < Participant
  include Helpers

  def assign_name
    @name = user_string("What's your name?")
  end

  private

  def make_decision
    user_choice("Hit or Stand?", { 'hit' => 'h', 'stand' => 's' })
  end
end

class TwentyOneGame
  include Helpers
  BUST_IF_OVER = 21
  NUM_DECKS_IN_SHOE = 1
  attr_reader :shoe, :dealer, :player

  def initialize
    @shoe = Shoe.new(NUM_DECKS_IN_SHOE)
    @dealer = Dealer.new("The Dealer")
    @player = Player.new
  end

  def start
    display_welcome_message
    assign_player_names
    loop do
      clear_screen
      shuffle_and_deal
      show_both_hands
      player_turn
      dealer_turn
      show_result
      break unless play_again?
    end
    display_goodbye_message
  end

  private

  def display_welcome_message
    prompt "Welcome to Twenty-One!"
  end

  def assign_player_names
    player.assign_name
  end

  def shuffle_and_deal
    shoe.collect_cards
    shoe.shuffle
    player.deal_new_hand(shoe)
    dealer.deal_new_hand(shoe)
  end

  def show_both_hands
    puts
    puts dealer.to_s
    puts player.to_s
    puts
  end

  def player_turn
    return if dealer.total == 'bj'
    player.play(shoe)
    puts
    sleep 1
  end

  def dealer_turn
    if ['bust', 'bj'].include?(player.result)
      dealer.record_result(dealer.total)
      dealer.show_hand
    else
      dealer.play(shoe)
    end
  end

  def show_tie_result
    if player.result == dealer.result
      prompt "It's a push, #{player.result} to #{dealer.result}."
      return true
    end
    false
  end

  def show_bust_result
    if player.result == 'bust'
      prompt "#{dealer.name} wins automatically since #{player.name} busted."
      return true
    elsif dealer.result == 'bust'
      prompt "#{player.name} wins automatically since #{dealer.name} busted."
      return true
    end
    false
  end

  def show_bj_result
    if player.result == 'bj'
      prompt "#{player.name} wins with Blackjack."
      return true
    elsif dealer.result == 'bj'
      prompt "#{dealer.name} wins with Blackjack."
      return true
    end
    false
  end

  def show_result
    puts
    return if show_tie_result || show_bust_result || show_bj_result
    player_result = player.result
    dealer_result = dealer.result
    if player_result > dealer_result
      prompt "#{player.name} wins, #{player_result} to #{dealer_result}."
    else
      prompt "#{dealer.name} wins, #{dealer_result} to #{player_result}."
    end
    puts
  end

  def play_again?
    user_choice("Play again?") == 'yes'
  end

  def display_goodbye_message
    puts
    prompt "Thanks for playing Twenty-One, #{player.name}. Goodbye!"
  end
end

TwentyOneGame.new.start
