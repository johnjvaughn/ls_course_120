require 'pry'

class Card
  include Comparable
  RANKS = %w[Jack Queen King Ace]
  SUITS = %w[Clubs Diamonds Hearts Spades]
  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    # go by suit order if ranks are the same
    return SUITS.index(suit) <=> SUITS.index(other_card.suit) \
      if rank == other_card.rank
    value <=> other_card.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    set_cards
  end

  def draw
    set_cards if @cards.empty?
    @cards.delete_at(rand(@cards.size))
  end

  private

  def set_cards
    @cards = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn
drawn.count { |card| card.rank == 5 } == 4
drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn.size == 52
p drawn.size == drawn2.size
p drawn != drawn2 # Almost always.